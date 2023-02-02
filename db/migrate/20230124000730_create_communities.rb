class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :bio
      t.string :img

      t.timestamps
    end
  end
end
