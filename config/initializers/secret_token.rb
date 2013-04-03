# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
  raise 'SECRET_TOKEN environment variable is not set!'
end

NorexBlog::Application.config.secret_token = ENV['SECRET_TOKEN'] || 'fabf4eed7752fc326640f816610ce4a6d7a47f561995aa3a3c4b0a61d7ecf274911b17a6aa1088b93af2781f3f39e7bcb22fa90551c3956c655a05d1a9cd2854'
