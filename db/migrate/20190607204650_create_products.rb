class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      %i[os cpu gps gpu nfc ram sim usb edge gprs wlan brand model radio colors status chipset
         battery img_url sensors weight_g announced bluetooth weight_oz audio_jack dimentions memory_card
         display_size display_type loud_speaker network_speed primary_camera internal_memory secondary_camera
         display_resolution network_technology].each { |column| t.string column }
      t.float :price

      t.timestamps
    end
    %i[model brand price ram internal_memory os].each { |column| add_index(:products, column) }
  end
end
