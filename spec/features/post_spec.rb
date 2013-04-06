require 'spec_helper'

feature 'Posts page' do
  scenario 'visits index when no tumbles are available' do
    visit root_path
    expect(page).to have_content('No posts are available')
  end


  scenario 'on individual posts page' do
    user = FactoryGirl.create(:user, blog_name: "Test User") 
    tumble = user.tumbles.create(title: 'Test Post', content: 'Test post content')

    visit tumble_path(tumble)
    
    expect(page).to have_content('Test Post')
    expect(page).to have_content('Test post content')

    expect(page).to have_content(user.blog_name)
    expect(page).to have_selector('#author-vcard h1', text: user.blog_name)

    expect(page).to have_selector('ul.share')
    expect(page).to have_selector('ul.tags')
    expect(page).to have_selector('ul.pagination')
    expect(page).to have_selector('#author-vcard')
  end
end