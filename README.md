# Live Chat

This project aims to develop a real-time messaging application where users can exchange messages individually or within the common group.

## Features

* Rails 7.1
* Ruby 3.2.2
* PostgreSQL
* Bun
* Bootstrap
* Devise
* Action Cable
* Dockerfile and Docker Compose configuration
* Tests
  * Rspec
  * Cucumber

## Requirements

- Ruby, Rails, Bun, Postgresql, Docker Compose V2

Check your docker compose version:
```
docker compose version
```

## Initial setup
```
docker compose build
```
```
docker compose run --rm web bin/rails db:setup
```
By default, the following ports are used: the application port is 4000, and the database port is 5435. If you wish to change the ports to match those already in use, execute the command:
```
cp .env.example .env
```
Then, set the necessary ports in the `.env` file, and Docker Compose will pick them up automatically.

## Running the application
```
docker compose up
```

After a successful launch, the application will be available at:

   * http://0.0.0.0:4000

or on another port you define.


## Running tests
To run all tests execute:
```
docker compose run --rm -e "RAILS_ENV=test" web bundle exec rake tests
```

To run Rspec tests execute:
```
docker compose run --rm -e "RAILS_ENV=test" web bundle exec rspec
```
or with the documentation format:
```
docker compose run --rm -e "RAILS_ENV=test" web bundle exec rspec -f d
```

To run Cucumber tests execute:
```
docker compose run --rm -e "RAILS_ENV=test" web bundle exec cucumber
```


## Utilization without Docker

Not much to mention except for utilizing the Bun.


Clone this repo and change to its root directory:

```
git clone https://github.com/andreybakanovsky/chat-live && cd chat-live
```
Install the Ruby gems:
```
bundle install
```

Install the Bun:

```
brew tap oven-sh/bun
```
then
```
brew install bun
```
and execute
```
bun install
```

Set up the database:
```
rails db:create db:migrate db:seed
```

Run the app:
```
bin/dev
```
then visit [http://localhost:3000](http://localhost:3000) in your browser.
