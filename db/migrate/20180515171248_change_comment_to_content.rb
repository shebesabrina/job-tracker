class ChangeCommentToContent < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :comment, :content
  end
end
