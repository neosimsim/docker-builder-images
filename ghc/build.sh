#!/bin/sh -e

imageName=neosimsim/ghc
clean=
verbose=

usage () {
cat <<EOF
usage: build.sh [-v] [-i IMAGE_NAME] [-c] VERSIONS...

-v		verbose
-i IMAGE_NAME	name of the docker image (default: $imageName)
-c		prune docker before build to safe storage

EOF
exit 1
}

while getopts 'vi:c' opt
do
	case $opt in
	v) verbose=1 ;;
	i) imageName=$OPTARG ;;
	c) clean=1 ;;
	?) usage ;;
	esac
done
shift $((OPTIND - 1))

case $# in
	0) usage ;;
	*) versions=$* ;;
esac

if [ -n "$verbose" ]
then
	set -o xtrace
fi

for ghcVersion in $versions
do
	if [ -n "$clean" ]
	then
		yes | docker system prune
	fi
	tag=$imageName:$ghcVersion
	docker build -t $tag -f Dockerfile-$ghcVersion .
	docker push $tag
done
