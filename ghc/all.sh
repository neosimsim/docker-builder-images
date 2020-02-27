case $# in
	0) versions="8.8.3 8.8.2 8.8.1 8.6.5"; break ;;
	*) versions=$*; break ;;
esac

for ghc_version in $versions
do
	yes | docker system prune
	tag=neosimsim/alpine-ghc:$ghc_version
	docker build -t $tag --build-arg GHC_VERSION=$ghc_version .
	docker push $tag
done
