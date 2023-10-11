class RemoveIsDraftFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :is_draft, :boolean
  end
end
