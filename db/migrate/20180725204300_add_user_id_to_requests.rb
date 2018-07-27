class AddUserIdToRequests < ActiveRecord::Migration[5.2]
  def change
      add_column :requests, :userID, :string
  end
end
