class CreateContests < ActiveRecord::Migration[7.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.text :about

      t.timestamps
    end
  end
end
