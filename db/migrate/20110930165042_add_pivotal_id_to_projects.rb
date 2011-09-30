class AddPivotalIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.column :pivotal_id, :string
    end
  end
end
