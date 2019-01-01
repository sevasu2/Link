class AlterMembers3 < ActiveRecord::Migration[5.2]
  def change
  	add_column :members, :git, :string
  	add_column :members, :introduction_name, :text
  	add_column :members, :portfolio, :string
  	add_column :members, :school, :string
  	add_index :members, [:name, :school]
  end
end
