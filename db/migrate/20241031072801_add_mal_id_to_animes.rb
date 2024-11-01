class AddMalIdToAnimes < ActiveRecord::Migration[7.2]
  def change
    add_column :animes, :mal_id, :integer
  end
end
