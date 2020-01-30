	while read ghc_version; \
		do docker build -t neosimsim/alpine-ghc:$ghc_version --build-arg GHC_VERSION=$ghc_version .; \
	done <ghc-versions
