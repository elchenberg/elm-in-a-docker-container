# Elm in a Docker Container

## Build the Container

```sh
$ docker build --tag elm .
```

## Run the Container

```sh
$ docker run --rm --interactive --tty --name elm --volume "$(pwd):/project" --workdir "/project" --publish "8000:8000" elm
```

or:

```sh
$ docker run --rm -it --name elm -v "$(pwd):/project" -w "/project" -p "8000:8000" elm
```

## Bash Alias

```sh
alias elm='docker run --rm --interactive --tty --name elm --volume "$(pwd):/project" --workdir "/project" --publish "8000:8000" elm'
```

## Caveats

- No REPL – unless you insert `COPY --from=node:11.6.0-stretch /usr/local/bin/node /usr/local/bin/node` before the `ENTRYPOINT` line. Or the builder stage could download the binary from [nodejs.org/en/download/](https://nodejs.org/en/download/>) similar to how it gets the elm binary.
- The cached build artifacts in the project directory need to be deleted when rerunning the container.