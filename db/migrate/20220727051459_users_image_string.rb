class UsersImageString < ActiveRecord::Migration[5.2]
  def change
    change_column(:users, :image, :string)
  end
end
