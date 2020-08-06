#!/bin/bash

source .env

Usage () {
  echo "---"
  echo "- [$0] launches a container that builds and serves the hugo project"
  echo "- [$0] is interative : when the hugo project is built and the hugo server started, it"
  echo "       will hang out on the [docker-compose logs -f] of the container."
  echo "       Hit [Ctrl + C] to exit [docker-compose logs -f], and the hugo source code will optionnally be "
  echo "       pushed to your feature branch using the git flow, see [--git-flow] option. "
  echo "---"
  echo "- Usage :"
  echo "---"
  echo "  $0 [options]"
  echo "---"
  echo "- Options :"
  echo "    --git-flow    if you provide this options invoking [$0] , then When you Ctrl + C to exit "

}
# Develop cycle :

echo "Congrats! Now the hugo project generated static content is under"
echo "the [$(pwd)/hugo/public] folder, and your site running at http:://localhost:1313/"
echo ''
echo " Hit [Ctrl + C] to exit the dev mode, modify your hugo source code, and re-run [$0] to see modifications"
echo ''
docker-compose up -d --build --force-recreate hugo_ide && deploy && docker-compose logs -f hugo_ide
# Congrats! Now the fresh hugo project source code is generated under the [src/] folder, and your site running at [${HUGO_BASE_URL}]

# And now you could do a commit and push (if you're satisfied with the result)
# --
# automatially commit and push to feature branch, using the
# git flow with 'git flow init --defaults' full default configuration
# Should be used only
commitAndPush () {
  if [ "x${COMMIT_MESSAGE}" == "x" ]; then
    echo "Your commit message is empty or not set"
    echo "set the COMMIT_MESSAGE env. var. to finish your git flow feature"
    exit 7
  fi;

  git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

  if [ "x${FEATURE_ALIAS}" == "x" ]; then
    echo "Your FEATURE_ALIAS is empty or not set"
    echo "set the FEATURE_ALIAS env. var. to finish your git flow feature"
    echo ""
    exit 8
  fi;

  git flow feature finish ${FEATURE_ALIAS} && git push -u origin --all && git push -u origin --tags
}

# And now you could do a release
if [ "x$1" == "x" ]; then
  echo "You did not provide the [--git-flow] option as first argument, commit message is empty or not set"
  echo "set the COMMIT_MESSAGE env. var. to finish your git flow feature"
else
  if ! [ "x$1" == "--git-flow" ]; then
    echo "You provided a first argument an unknown option : the [--git-flow] option is the only allowed value as first argument of [$0]"
    Usage
    exit 9
  else

  fi;
fi;
