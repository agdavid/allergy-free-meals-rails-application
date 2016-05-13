class AddMottoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :motto, :text
  end
end
