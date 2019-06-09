module ProductsHelper
  def brand_filters
    %w[acer apple asus blackberry google htc huawei lg micromax motorola nokia oneplus oppo samsung sony]
  end

  def internal_memory_filters
    %w[2 8 16 32 64 128 256 512]
  end

  def ram_filters
    %w[1 2 3 4 6 8]
  end

  def sorting_filters
    [['Price (Low to High)', 'price asc'],
     ['Price (High to Low)', 'price desc'],
     ['Name (Ascending)', 'model asc'],
     ['Name (descending)', 'model desc']]
  end

  def product_link(product_id)
    options = params.as_json.select! { |k, _v| filter_types.include? k }
    product_path(product_id, options)
  end

  def products_link(opts = {})
    options = params.as_json.select! { |k, _v| filter_types.include? k }
    products_path(options.merge(opts))
  end

  private

  def filter_types
    %w[brand internal_memory ram min_price max_price sort_by]
  end
end
