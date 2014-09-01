class AddDataToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :distance, :decimal
    add_column :tracks, :total_ascent, :decimal
    add_column :tracks, :total_descent, :decimal
  end
end
