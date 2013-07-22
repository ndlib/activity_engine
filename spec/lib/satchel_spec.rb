require 'spec_helper'

describe Satchel do

  # Satchel.register('ApplicationController#new') do |registry, context|
  #   registry.subject = context.person

  #   # Assumes to context.current_user
  #   registry.current_user = context.current_user

  #   # Assumes to be Class#method
  #   registry.activity_type = 'ApplicationController#new'
  #   registry.message = "Hello World"
  # end

  describe 'entry creation' do
    it 'creates an entry for a persisted object'
    it 'requires an object to be persisted'
    it 'extracts the requesting user from the context'
    it 'extracts the entry type from the context'
  end

  describe 'entry finder scopes' do
    it 'has a scope for finding based on the persisted object'
    it 'has a scope for finding based on a user'
    it 'has a scope for finding based on an entry type'
  end
end