class Comment < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :post
  has_many :comment_votes

  def getPoints
    upvote_count = CommentVote.where("comment_id = ? AND is_upvote = ?", self.id, true).count
    downvote_count = CommentVote.where("comment_id = ? AND is_upvote = ?", self.id, false).count

    points = upvote_count - downvote_count

    points
  end

end
