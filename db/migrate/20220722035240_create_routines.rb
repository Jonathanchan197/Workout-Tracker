class CreateRoutines < ActiveRecord::Migration[5.2]
  def change
    create_table :routines do |t|
      t.text :title

      t.timestamps
    end
  end
end
