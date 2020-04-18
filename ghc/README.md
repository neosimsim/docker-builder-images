# GHC
A Docker image containing [The Glasgow Haskell Compiler](https://www.haskell.org/ghc/)
and (Haskell Cabal)[https://www.haskell.org/cabal/] based on [musl libc](https://www.musl-libc.org/).

This image in intended to be used to build full statically linked Haskell application.

To build a bunch of containers with different versions, you can edit
[ghc-versions](ghc-versions) and run [all.sh](all.sh).

## Troubleshooting
### rejecting: integer-gmp

Note that GHC is built with integer-simple. Some packages do depend on integer-gmp. In general these packages provide flags to change the required integer package.

E.g. if you get the an error like

	cabal: Could not resolve dependencies:
	40 [__0] trying: oidc-token-viewer-0.1.1.0 (user goal)
	41 [__1] trying: tls-1.5.4 (dependency of oidc-token-viewer)
	42 [__2] trying: cryptonite-0.26 (dependency of tls)
	43 [__3] trying: cryptonite:+integer-gmp
	44 [__4] next goal: integer-gmp (dependency of cryptonite +integer-gmp)
	45 [__4] rejecting: integer-gmp-1.0.2.0, integer-gmp-1.0.1.0,
	46 integer-gmp-1.0.0.1, integer-gmp-1.0.0.0, integer-gmp-0.5.1.0 (only already
	47 installed instances can be used)
	48 [__4] fail (backjumping, conflict set: cryptonite, integer-gmp,
	49 cryptonite:integer-gmp)

you can run

	cabal v2-configure --constraint 'cryptonite -integer-gmp'

or

	cabal v2-configure --constraint 'scientific +integer-simple'

This will write proper constraints to you cabal.project.local.
Source

## References
### Docker Hub
<https://registry.hub.docker.com/r/neosimsim/ghc>

