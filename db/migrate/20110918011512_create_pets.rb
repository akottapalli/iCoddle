class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :age
      t.date :dob
      t.text :notes

      t.timestamps
    end
  end
end
