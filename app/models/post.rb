require 'dm-timestamps'
class Post
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime, :default => nil

end
