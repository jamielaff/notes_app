class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references  :user,        null: false
      t.string      :title,       null: false
      t.text        :description, null: false
      t.timestamps
    end
  end
end
