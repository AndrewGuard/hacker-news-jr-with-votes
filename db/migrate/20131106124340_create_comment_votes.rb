class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.boolean :is_upvote
      t.integer :comment_id
      t.integer :user_id

      t.timestamps
    end
  end
end
