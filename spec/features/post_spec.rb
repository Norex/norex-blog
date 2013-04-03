require 'spec_helper'

feature 'Posts page' do
  scenario 'visits index when no tumbles are available' do
    visit root_path
    expect(page).to have_content('No posts are available')
  end
end