class AddChurchesIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :church_id, :integer
  end
end
