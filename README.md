# Satchel

A mountable Rails engine for both recording activity and displaying activity on
a persisted object.

## Installation

Add this line to your application's Gemfile:

    gem 'satchel'

And then execute:

    $ bundle

Then run:

    $ rails g satchel:install

## Register a Method

To record activity, register a class and method via a Rails generator.

    $ rails g satchel:register <ClassName> <MethodName> <Subject>

Or by hand in a config/initializers/satchel_config.rb

    Satchel.register('<ClassName>', '<MethodName>') do |activity,context|
      activity.subject = context.<subject>
      activity.user = context.current_user
      activity.activity_type = "an arbitrary type"
      activity.message = "A particulare message?"
    end

Then, whenever the ClassName#MethodName is invoke an activity will be recorded.

## TODO

* Provide a means for retrieving an object's activities