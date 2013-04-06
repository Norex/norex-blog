require 'spec_helper'

feature 'Layouts' do
  scenario 'home page should be at /' do
    visit root_path

    expect(page).to have_selector('section#main-sidebar')
    first('head title').native.text.should == 'Norex Blog'
  end
end