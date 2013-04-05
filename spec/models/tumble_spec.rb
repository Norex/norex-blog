require 'spec_helper'

describe Tumble do
  before(:each) do 
    @tumble = FactoryGirl.create(:tumble)
    @user = FactoryGirl.create(:user)
    @attr = { content: 'lorem ipsum' }
  end

  it 'should create a new instance with valid attributes' do
    @user.tumbles.create(@attr)
  end

  it 'should respond to content' do 
    @tumble.should respond_to(:content) 
  end

  it 'should respond to content_type' do
    @tumble.should respond_to(:content_type)
  end

  it 'should respond to date' do
    @tumble.should respond_to(:date)
  end

  it 'should respond to title' do 
    @tumble.should respond_to(:title) 
  end

  it 'should respond to tumblr_id' do 
    @tumble.should respond_to(:tumblr_id)
  end

  it 'should respond to url' do 
    @tumble.should respond_to(:url) 
  end

  describe 'user associations' do
    before(:each) do
      @tumble = @user.tumbles.create(@attr)
    end

    it 'should have a user attribute' do
      @tumble.should respond_to(:user)
    end

    it 'should have the correct associated user' do
      @tumble.user_id.should == @user.id
      @tumble.user.should == @user
    end
  end

  describe 'tagging' do
    before (:each) do
      @tag_list = ['test1', 'test2', 'test3']
      @tumble = FactoryGirl.create(:tumble, tag_list: @tag_list)
    end

    it 'should respond to tag_list' do
      @tumble.should respond_to(:tag_list)
    end

    it 'should return the correct tags array' do
      @tumble.tag_list.should == @tag_list
    end
  end

  describe 'fetching new tumbles' do
    before(:all) do
      Tumble.destroy_all
      @initial_tumble_count = Tumble.count
      Tumble.fetch_new
    end

    it 'should respond to fetch_new' do
      Tumble.should respond_to(:fetch_new)
    end

    it 'should increase the count' do
      Tumble.count.should_not == @initial_tumble_count
    end

    it 'should associate a Tumble with a user' do
      Tumble.first.user.should_not == nil
    end

    after(:all) do
      Tumble.destroy_all
    end
  end
end