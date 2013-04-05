require 'spec_helper'

feature 'Posts page' do
  # before(:each) do
  #   Tumble.destroy_all
  # end
  
  scenario 'visits index when no tumbles are available' do
    visit root_path
    expect(page).to have_content('No posts are available')
  end

  scenario 'on individual posts page' do
    user = FactoryGirl.create(:user, blog_name: "Test User", description: 'Test user description') 
    tumble = user.tumbles.create(title: 'Test Post', content: 'Test post content')

    visit tumble_path(tumble)

    first('head title').native.text.should have_content(tumble.title) 
    expect(page).to have_content('Test Post')
    expect(page).to have_content('Test post content')

    expect(page).to have_content(user.blog_name)
    expect(page).to have_selector('#author-vcard h1', text: user.blog_name)
    expect(page).to have_selector('#author-vcard h3', text: user.description)

    expect(page).to have_selector('ul.share')
    expect(page).to have_selector('ul.tags')
    expect(page).to have_selector('ul.pagination')
    expect(page).to have_selector('#author-vcard')
  end

  scenario 'searching with results' do
    query = 'test'
    user = FactoryGirl.create(:user, blog_name: "Test User", description: 'Test user description') 
    tumble1 = user.tumbles.create(title: 'Test Post', content: 'Test post content')
    tumble2 = user.tumbles.create(title: 'Not on search page', content: 'This is not on the search page')

    visit search_path(query: query)

    first('head title').native.text.should have_content("Search: #{query}") 
    expect(page).to have_content('Test Post')
    expect(page).to have_content('Test post content')
    expect(page).to_not have_content('Not on search page')
    expect(page).to_not have_content('This is not on the search page')
  end
end