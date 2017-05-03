FROM haskell:latest

ENV PANDOC_VERSION "1.19.2.1"

RUN cabal update && cabal install pandoc-${PANDOC_VERSION}

CMD ["/root/.cabal/bin/pandoc"]
