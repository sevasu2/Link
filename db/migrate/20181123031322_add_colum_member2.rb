class AddColumMember2 < ActiveRecord::Migration[5.2]
  def change
  	add_column :members, :introduction, :text
  end
end
