# Dockerizied SonarQube

This repository contains configuration and instructions to run SonarQube using Docker (and Docker compose).

## Requirements

 The only thing you need is Docker. Get it [here](https://www.docker.com/community-edition)

If you are running Windows, you might need to do some additional setup to get Docker working. Refer to [guide](https://docs.docker.com/docker-for-windows/) and [this](https://docs.docker.com/toolbox/toolbox_install_windows/#step-1-check-your-version) guide. At least run the quickstart to get started.

You will also need to modify the settings for the VirtualBox machine Docker is using.

    Go to VirtualBox -> Your BOX -> Settings -> Network ->
    Choose NAT
    Open Advanced
    Click Port Forwarding
    Add new rule to map whatever port you need from host to guest(for example 3000 to 3000)
    Click OK, OK
    Then stop, start the BOX

## Running the server

* Copy the env-example -file at the repository root to .env. Modify the variables if you deem necessary:

The version of SonarQube you want to install.
SONAR_VERSION

Internal Docker port and external port
By default the internal port should be 9000
SONARQUBE_EXTERNAL_HOST_PORT
SONARQUBE_INTERNAL_DOCKER_PORT

Database variables

DATABASE_USERNAME
DATABASE_PASSWORD
DATABASE_URL=jdbc:postgresql://db:5432/sonar

If you connect to an external database, specify connection details here. Specify the database name at the end of the connection string.

If you want to use a web context with SonarQube, specify it here.
WEB_CONTEXT=/sonarX

If you want to test locally, invoke the following command at the repository root

    docker-compose up --build -d


This will build/pull the needed the docker images and start the respective container in the background. You can drop the --build option if you want to use the existing images.

The server will now reply on localhost, from the port you specified in the .env file. 

If you use a separate database, use 

    docker-compose start sonarqube

instead.

