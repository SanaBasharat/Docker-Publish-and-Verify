#Logging out in case some user is already logged in
command=$(docker logout 2>&1)
if [ "$?" != "0" ]; then
	echo "Error logging out"
	exit 1
fi

echo "Enter DockerHub username: "
read u_name

echo "Enter DockerHub password: "
read pass

echo -e "\nPlease wait while you are logged in...\n"

command=$(docker login --username $u_name --password $pass 2>&1)
if [ "$?" != "0" ]; then
	echo "Error"
	exit 1
fi

echo "Enter your repository name: "
read repo_name

echo "Enter the tag: "
read repo_tag

#echo -e "\nFreeing up port 80..."
#command=$(fuser -k 80/tcp)

if [ "$?" != "0" ]; then
	echo "Error in fuser"
	exit 1
fi

echo -e "\nPlease wait while the image is being pulled and run...\n"

#Pulling and running image
command=$(docker pull "$u_name/$repo_name:$repo_tag" 2>&1)
if [ "$?" != "0" ]; then
	echo "Error in docker pull"
	exit 1
fi

command=$(docker run -d -p 80:80 "$u_name/$repo_name:$repo_tag" 2>&1)
if [ "$?" != "0" ]; then
	echo -e "\nError in docker run command. Port 80 is already in use. Trying with port 8080 now...\n"
	command=$(docker run -d -p 8080:80 "$u_name/$repo_name:$repo_tag" 2>&1)
	if [ "$?" != "0" ]; then	
		echo "Looks like your ports are in use. Please free them up and try again."
		echo $command
		exit 1
	fi
fi

#curl
command=$(curl -s localhost:80 2>&1)
if [ "$?" != "0" ]; then
	echo "Error in curl command"
	echo $command
	exit 1
fi

#verifying that content is the same
echo -e "Checking result of curl with index.html...\n"
if [[ $(< index.html) != "$command" ]]; then
	echo -e "\nError! Content not the same as index.html\n"
else
	echo -e "Success! Content is the same!\n"
	echo $command
fi
