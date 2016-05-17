class AddAttachmentImageToAllergens < ActiveRecord::Migration
  def self.up
    change_table :allergens do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :allergens, :image
  end
end
