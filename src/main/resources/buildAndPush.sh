#! /usr/bin/bash


DOCKER_REGISTRY_URL="10.5.197.63:37966"
BUILD_PATH=${project.basedir}
DOCKER_FILE_PATH="${project.basedir}/target/classes/Dockerfile"
BUILD_COMMAND_ARGS="docker build"

EXEC_BUILD_COMMAND="$BUILD_COMMAND_ARGS -t ${project.artifactId}:${project.version} -f $DOCKER_FILE_PATH --rm=true --force-rm=true
$BUILD_PATH"
echo -e "\n***"
echo "***** Executing Docker Image BUILD Command: $EXEC_BUILD_COMMAND ..."
echo "***"
$EXEC_BUILD_COMMAND
if [ $? -ne 0 ]; then
  echo "*************************"
  echo "Docker build failed ..."
  echo "*************************"
  exit -1
fi


EXEC_REMOVE_INTERMEDIARIES_COMMAND="docker rmi -f $(docker images -q --filter dangling=true)"
echo -e "\n***"
echo "***** Deleting unwanted intermediaries, Command: $EXEC_LIST_COMMAND ..."
echo "***"
$EXEC_REMOVE_INTERMEDIARIES_COMMAND
if [ $? -ne 0 ]; then
  echo ""
fi


#
# Push to Registry only when running in Jenkins, not during local builds
#
echo -e "\n***"
echo "****** Push to Registry: $pushToRegistry"
echo "***"

if [ "$pushToRegistry" != "false" ]; then
  EXEC_TAG_COMMAND="docker tag -f ${project.artifactId}:${project.version} \
    $DOCKER_REGISTRY_URL/${project.artifactId}:${project.version}"
  echo -e "\n***"
  echo "***** Executing Docker Image TAG Command: $EXEC_TAG_COMMAND ..."
  echo "***"
  $EXEC_TAG_COMMAND



  EXEC_PUSH_COMMAND="docker push $DOCKER_REGISTRY_URL/${project.artifactId}:${project.version}"
  echo -e "\n***"
  echo "*** Executing Docker Image PUSH Command: $EXEC_PUSH_COMMAND ..."
  echo "***"
  $EXEC_PUSH_COMMAND
  if [ $? -ne 0 ]; then
    echo "******************************************"
    echo "Docker push to remote registry failed ..."
    echo "******************************************"
    exit -1
  fi
fi




