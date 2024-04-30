# Live Chat

This project aims to develop a real-time messaging application where users can exchange messages individually or within the common group.

## Requirements

- Ruby 3.2.2
- Rails 7.1.3
- Bun
- Postgresql

## Installation

Clone this repo and change to its root directory

`git clone https://github.com/andreybakanovsky/chat-live && cd chat-live`

Install the Ruby gems

`bundle install`

Install the Bun

`brew tap oven-sh/bun`
`brew install bun`

and execute

`bun install`

Set up the database

`rails db:create`
`rails db:migrate`
`rails db:seed`

## Testing

To run all tests execute

`rake tests`

Run Rspec tests

`bundle exec rspec` or `bundle exec rspec -f d` with the documentation format

Run Cucumber tests

`bundle exec cucumber`

## Run app

In the `chat-live` project directory, run

`bin/dev`

Visit [http://localhost:3000](http://localhost:3000) in your browser.
