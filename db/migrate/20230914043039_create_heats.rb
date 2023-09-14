class CreateHeats < ActiveRecord::Migration[7.0]
  def change
    create_table :heats do |t|
      t.string :name
      t.datetime :start_time
      t.string :slug
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
