class AddActiveFlagToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :is_active, :boolean, default: false
    Note.update_all(is_active: true)
  end
end
