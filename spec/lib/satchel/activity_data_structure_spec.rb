require 'spec_helper'
require 'satchel/activity_data_structure'

describe Satchel::ActivityDataStructure do
  subject { Satchel::ActivityDataStructure.new }
  it { should respond_to :current_user }
  it { should respond_to :subject }
  it { should respond_to :message }
  it { should respond_to :activity_type }
end
