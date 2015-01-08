class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :resident_Pastor

      t.timestamps
    end
  end
end
