# AMPAGE

Ampage is a Rails web app where members can share and review guitar amplifiers. Features include CRUD functionality for both amplifiers and reviews, an AJAX implemented up vote/down vote system for reviews, search by amplifier manufacturer capability and Devise implemented user authentication/authorization.

This project uses the following libraries and frameworks:

- Ruby on Rails
- Javascript
- AJAX

## Demo

For a live demo of the app, please visit: [Ampage](https://ampage.herokuapp.com)

## Setup

This app uses Ruby 2.2.5 and was developed on Ruby on Rails 5.0.3. 

To install, please run the following in your terminal: 

### Set up Rails

```
git clone https://github.com/jarouca/guitar-amplifier-review-site.git
cd online-review-site
bundle install
rake db:create
rake db:migrate
```

## Running the application

To run Ampage, please run the following command in your terminal from the online-review-site directory:

`rails s`

Now open your browser and enter localhost:3000 in your address bar.

## Testing

To run the test suite, please enter the following command from the online-review-site root directory:

`rspec`
