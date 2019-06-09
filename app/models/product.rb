class Product < ApplicationRecord
  BATCH_SIZE = 1000

  scope :by_brand, ->(brand) { where('lower(brand) = ?', brand.to_s.downcase) }
  scope :by_ram, ->(ram) { where('lower(ram) like lower(?)', "%#{ram.to_i} GB%") }
  scope :by_internal_memory, lambda { |internal_memory|
                               where(
                                 'lower(internal_memory) like lower(?) and lower(internal_memory) like lower(?)',
                                 "%#{internal_memory.to_i}%", '%gb%'
                               )
                             }
  scope :by_os, ->(os) { where('lower(os) like lower(?)', "%#{os}%") }
  scope :by_min_price, ->(price) { where('price >= ?', price.to_f) }
  scope :by_max_price, ->(price) { where('price <= ?', price.to_f) }
end
