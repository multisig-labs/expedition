# Justfiles are better Makefiles (Don't @ me)
# Install the `just` command from here https://github.com/casey/just
# or if you have rust: cargo install just
# https://cheatography.com/linux-china/cheat-sheets/justfile/

# Autoload a .env if one exists
set dotenv-load

default:
	@just --list --unsorted

docker-build:
	DOCKER_BUILDKIT=1 docker build --platform linux/arm64 -t multisig-labs/expedition .

docker-run *cmd:
	docker run -it -p 8000:80 \
	  --name expedition \
		--rm multisig-labs/expedition {{cmd}}

# Run a cmd (i.e. bash) inside a running container
docker-exec *cmd:
	docker exec -it expedition {{cmd}}

fly-deploy:
  fly deploy --config fly.toml --app expedition
