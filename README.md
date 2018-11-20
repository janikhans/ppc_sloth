# PPC Sloth

PPC Sloth is a quick and dirty keyword analyzer for Amazon Search Term Reports. It'll
help in creating better advertising campaigns by optimizing keywords.

## The Stack

Build using the [Ruby on Rails](http://rubyonrails.org/) framework and using a
typical RoR stack including Postgres and Sidekiq. Production app is currently deployed on Heroku.

## Basic Overview

Todo

## Running it on your machine

Clone this repo to your local machine:

    git clone https://github.com/janikhans/ppc_sloth.git
    bundle install
    rake db:reset
    rails s

Now the Rails app should be running, head over to `localhost:3000` in a browser to
start interacting with the app.

Huzzah!

## More setup

##### Mock data (with dump file)

Get a database dump file and run:

    pg_restore --verbose --clean --no-acl --no-owner -d ppc_sloth_development DUMPFILE # Make sure to substitute DUMPFILE with the correct file name.
    rake db:migrate

##### Mock data (with seeds)

The seeds file is a decent representation of a typical production database with
randomized data. If running it for the first time with `rake db:reset`, this should
already be loaded. Otherwise run:

    rake db:seed

##### Export local database

    pg_dump -Fc --no-acl --no-owner ppc_sloth_development > local.dump

## Where to find things

todo

#### The app interface

* Dashboard
* Campaigns

## Future Goals

* Add Users
* Admins
* ...

## Contact

If you need to get a hold of Janik, please email janik.knittle@gmail.com. But
realistically if you're looking at this, you're probably someone special and
should have Janik's phone number anyways.

# Git-r-dun!
