# Docker-Publish-and-Verify
Deploy and test an "nginx" container using Linux shell script

Shell script to deploy a small webpage into an "nginx" container:
 - It pulls the standard nginx container and replaces some arbitrary index.html into it 
 - It takes the name of the repository from the user
 - It takes the name of the container from the user
 - It takes the tag of the container
 - It logins into the docker repository of the user
 - It pushes the newly formed container onto the repository provided by the user using user's account
 - If there is an error during these steps, the script gives a helpful message so that the user can act upon it and proceed to the next steps.

Shell script to test the deployed "nginx" container:
 - It takes the name of the repository from the user
 - It takes the name of the container from the user
 - It takes the tag of the container
 - It pulls the container and starts it by mapping to port 80
 - It uses curl to receive a response from the container
 - It verifies that the response is the same as you have written in the previous assignment. 
 - If there is an error during these steps, the script gives a helpful message so that the user can act upon it and proceed to the next steps.
