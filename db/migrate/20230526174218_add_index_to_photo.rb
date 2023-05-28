class AddIndexToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_index :photos, :date_taken
  end
end
