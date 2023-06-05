class AddUserIdToBookComments < ActiveRecord::Migration[6.1]
  def change
    add_column :book_comments, :name, :integer
  end
end
