namespace :posts do
  desc 'Fetch new posts from tumblr'
  task :fetch_new => :environment do 
    Tumble.fetch_new
  end
end