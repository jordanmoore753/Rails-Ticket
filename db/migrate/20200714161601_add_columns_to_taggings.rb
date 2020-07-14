class AddColumnsToTaggings < ActiveRecord::Migration[6.0]
  def change
    add_reference :taggings, :tag 
    add_reference :taggings, :ticket
  end
end
