class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
