class RemoveStatusFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :status, :integer
  end
end
