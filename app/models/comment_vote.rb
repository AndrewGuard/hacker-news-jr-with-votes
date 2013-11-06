class CommentVote < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :comment
  belongs_to :user
end
