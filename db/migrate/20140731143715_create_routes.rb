class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :title
      t.text :description
      t.float :distance
      t.float :total_ascent

      t.timestamps
    end
  end
end
