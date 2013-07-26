# ActivityEngine

[![Build Status](https://travis-ci.org/ndlib/activity_engine.png)](https://travis-ci.org/ndlib/activity_engine)

A mountable Rails engine for both recording activity and displaying activity on
a persisted object.

## Installation

Add this line to your application's Gemfile:

    gem 'activity_engine'

And then execute:

    $ bundle

Then run:

    $ rails g activity_engine:install

## Register a Method

To record activity, register a class and method via a Rails generator.

    $ rails g activity_engine:register <ClassName> <MethodName> <Subject>

Or by hand in a config/post_initializers/activity_engine_config.rb

    ActivityEngine.register('<ClassName>', '<MethodName>') do |activity,context|
      activity.subject = context.<subject>
      activity.user = context.current_user
      activity.activity_type = "an arbitrary type"
      activity.message = "A particulare message?"
    end

Then, whenever the ClassName#MethodName is invoke an activity will be recorded.
