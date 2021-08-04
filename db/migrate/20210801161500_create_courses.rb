class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.boolean :self_assignable, index: true
      t.references :coach, index: true

      t.timestamps
    end
  end
end

