class CreateFaces < ActiveRecord::Migration[5.1]
  def change
    create_table :faces do |t|
      t.string :face_data
      t.string :identify

      t.timestamps
    end
  end
end
