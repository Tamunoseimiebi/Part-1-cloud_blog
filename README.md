Techpet Global DevOps Interns Challenge Part 1
Cloud Blog Web Application
This is a Flask application that lists the latest articles within the cloud-native ecosystem.

Instructions:

1. Fork this repo
2. Create an optimized dockerfile to dockerize the application.
3. Use any CICD tool of your choice, create a pipeline that will dockerize and deploy to your docker hub.
4. Create your own Readme.md file to document the process and your choices.

Task 1: Dockerize the App

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
# syntax=docker/dockerfile:1 it tells the Docker builder what syntax to use while parsing the Dockerfile and the location of the Docker syntax file. it is optional and can be ignored.

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
	


