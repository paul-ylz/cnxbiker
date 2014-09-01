class RemoveColumnsFromRoute < ActiveRecord::Migration
  def change
    remove_column :routes, :distance
    remove_column :routes, :total_ascent
  end
end
