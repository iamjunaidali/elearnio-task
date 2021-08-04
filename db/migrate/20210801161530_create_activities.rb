class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.references :course, index: true

      t.timestamps
    end
  end
end
