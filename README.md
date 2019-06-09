# Installation

1. Install [Docker](https://www.docker.com/)
1. Install [Docker Compose](https://docs.docker.com/compose/install/)
1. run `make build`
2. run `make db-seed`
3. run `make server` and open `http://localhost:3000` in the browser

## Usage

1. `make build` to launch the stack for the first time
1. `make server` to launch the stack
1. `make down` to bring down all containers
1. `make db-build-all` to create the DATABASE
1. `make db-seed` to seed the DATABASE
