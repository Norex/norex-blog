class User < ActiveRecord::Base
  attr_accessible :blog_name, :description, :name, :photo

  has_many :tumbles
end
