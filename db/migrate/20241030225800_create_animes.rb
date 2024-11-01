class CreateAnimes < ActiveRecord::Migration[7.2]
  def change
    create_table :animes do |t|
      t.float :score
      t.text :description
      t.string :title
      t.integer :episodes
      t.string :status

      t.timestamps
    end
  end
end
