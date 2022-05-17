**Techpet Global DevOps Interns Challenge Part 1**

Cloud Blog Web Application
This is a Flask application that lists the latest articles within the cloud-native ecosystem.

*Instructions:*

1. Fork this repo
2. Create an optimized dockerfile to dockerize the application.
3. Use any CICD tool of your choice, create a pipeline that will dockerize and deploy to your docker hub.
4. Create your own Readme.md file to document the process and your choices.



*Task 1: Dockerize the App*

Clone the forked repo with the following command:
 git clone https://github.com/Tamunoseimiebi/Part-1-cloud_blog.git
	
Create a Dockerfile inside the project directory with your favourite editor:
 nano Dockerfile
		
#PASTE THE FOLLOWING CONTENT INSIDE THE Dockerfile	

	# syntax=docker/dockerfile:1

	FROM python:3.8-slim-buster

	WORKDIR /Part-1-cloud_blog

	COPY requirements.txt requirements.txt
	RUN pip3 install -r requirements.txt

	COPY . .

	CMD [ "python", "init_db.py" ]

	CMD [ "python", "app.py"]
	
	
Save file and exit

Dockerfile explained:

syntax=docker/dockerfile: it tells the Docker builder what syntax to use while parsing the Dockerfile and the location of the Docker syntax file. it is optional and can be ignored.

FROM python:3.8-slim-buster : This line tells Docker which base image to use — in this case, a Python image. 

WORKDIR /Part-1-cloud_blog : The WORKDIR command is used to define the working directory of a Docker container at any given time. The command is specified in the Dockerfile.

COPY requirements.txt requirements.txt : Here we tell Docker to copy the contents of our requirements.txt file into the container image's requirements.txt file. 

RUN pip3 install -r requirements.txt: Here we tell Docker to run pip install to install all the dependencies in the same file to be used by the image.

COPY . .   Here we are telling Docker to copy all the  files in our local working directory to the directory in the docker image.

CMD [ "python", "init_db.py" ] : This commands Docker to initialize the database file "database.db".

CMD [ "python", "app.py"] : THis command is used to start the application.


With our Dockerfile set up, the next step is to build our docker image with this command:

 docker build --tag cloud_blog_app .

Run the app to test if it works:
 docker run cloud_blog_app .

If you get this error "ImportError: cannot import name 'escape' from 'jinja2' " Update flask and Werkzeug packages in the requirements file to a stable version. In my case  Flask==2.1.0 and Werkzeug==2.0.0 solved this problem.

Run docker build command again:  docker run cloud_blog_app .

The app should run successfully and be available at http://localhost:3111


*Task 2: CI/CD FIle to dockerize the app and publish to Dockerhub*

1.  Create a .github/workflows folder.

	mkdir -p .github/workflows
	
2. Create a .yml file for the pipeline. e.g flask-image.yml

	nano .github/workflows/flask-image.yml

3. Paste in the following code into the file:


		name: Dockerhub CI/CD
		on:
		  push:
		    branches:
		      - main
		# Env variable
		env:
		  DOCKER_USER: ${{secrets.DOCKER_USER}}
		  DOCKER_PASSWORD: ${{secrets.DOCKER_PASSWORD}}
		  REPO_NAME: ${{secrets.REPO_NAME}}
		jobs:
		  build-image-and-push-image:  # job name
		    runs-on: ubuntu-latest  # runner name : (ubuntu latest version) 
		    steps:
		    - uses: actions/checkout@v2 # first action : checkout source code
		    - name: docker login
		      run: | # log into docker hub account
			docker login -u $DOCKER_USER -p $DOCKER_PASSWORD  
		    - name: Build the Docker image # push The image to the docker hub
		      run: docker build . --file Dockerfile --tag tamunoseimiebi/cloud_blog_app
		    - name: Docker Push
		      run: docker push tamunoseimiebi/cloud_blog_app


CI/CD File explained:

The CI/CD file has three major segmesnts namely: name, env and jobs.

a. Name: Contains useful metadata and other information that describes when the pipeling is triggered and what github branch triggers it.

b. Env: Refers to useful environment variables needed to connect to docker hub.

c. jobs: Refers to the various stages of the pipeline. The pipepline first builds the Dockerfile whenever a commit is made on the main branch and then pushes the generated docker image to Docker Hub.


