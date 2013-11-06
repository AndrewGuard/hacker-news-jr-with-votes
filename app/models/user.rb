class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts
  has_many :comments
  has_many :post_votes
  has_many :comment_votes

  validates :email, :uniqueness => true

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if (!user.nil? && password == user.password)
      user
    else
      nil
    end
  end
end


