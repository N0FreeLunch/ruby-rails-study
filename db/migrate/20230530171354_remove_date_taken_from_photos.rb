class RemoveDateTakenFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :date_taken, :datetime
  end
end
