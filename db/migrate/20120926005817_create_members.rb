class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :github
      t.string :telefone
      t.text :bio

      t.timestamps
    end
  end
end
