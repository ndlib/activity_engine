require 'spec_helper'

# NOTE: These specs are very much tied into the output of the
# `rake dummy:scaffold` commands. A change in those means a likely
# change in the behavior.
describe 'DummyScaffoldActivity', type: :feature do

  it 'when I do a registered activity it is recorded' do
    expect {
      visit('/watches/new')
      click_button("Create Watch")
    }.to change{ActivityEngine::Activity.count}.by(1)
  end

  it 'when I do a non-registered activity it is not recorded' do
    expect {
      visit('/invisibles/new')
      click_button("Create Invisible")
    }.to_not change{ActivityEngine::Activity.count}
  end

end