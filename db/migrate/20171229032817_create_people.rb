class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :detail
      t.float :score

      t.timestamps
    end
  end
end
