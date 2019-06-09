require 'json'

file = File.open Rails.root.join('db', 'dummy_data.json')
data = JSON.parse(file.read)

data.each_slice(Product::BATCH_SIZE) do |batch|
  mobile_data = batch.each_with_object([]) do |record, records|
    record.transform_keys!(&:downcase)
    record.transform_values!(&:downcase)
    record.transform_values!(&:strip)
    attrs = record.select! { |k, _v| Product.column_names.include? k }
    records.push(Product.new(attrs.merge(price: Random.rand(1000..80_000))))
  end
  Product.import(mobile_data)
end

puts 'Done'
