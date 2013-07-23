require 'spec_helper'
require 'activity_engine/activity_data_structure'

describe ActivityEngine::ActivityDataStructure do
  subject { ActivityEngine::ActivityDataStructure.new }
  it { should respond_to :current_user }
  it { should respond_to :subject }
  it { should respond_to :message }
  it { should respond_to :activity_type }
end
