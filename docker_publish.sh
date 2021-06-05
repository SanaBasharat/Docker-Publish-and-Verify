
command=$(docker logout 2>&1)
if [ "$?" != "0" ]; then
	echo "Error logging out"
	exit 1
fi

echo "Enter DockerHub username: "
read u_name

echo "Enter Dockerhub password: "
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

echo -e "\nPlease wait while the image is being built...\n"


if ! [[ -f "Dockerfile" ]]; then
	echo "Dockerfile does not exist"
	exit 1
fi
if ! [[ -f "index.html" ]]; then
	echo "index.html does not exist"
	exit 1
fi

#Building image using Dockerfile
command=$(docker build -t "$u_name/$repo_name:$repo_tag" . 2>&1)
if [ "$?" != "0" ]; then
	echo "Error building image"
	echo $command
	exit 1
fi

echo -e "\nPlease wait while the image is being pushed...\n"

#Pushing image
command=$(docker push "$u_name/$repo_name:$repo_tag" 2>&1)
if [ "$?" != "0" ]; then
	echo "Error pushing image"
	exit 1
fi

echo -e "Success!\n"




