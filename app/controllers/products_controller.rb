class ProductsController < ApplicationController
  before_action :load_products, only: :index
  before_action :load_product, only: :show

  def index
    respond_to do |format|
      format.html { @products = @products.page(params[:page]) }
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="all_products.xlsx"' }
    end
  end

  def show; end

  def apply_filter
    options = filter_options
    redirect_to products_path(options)
  end

  private

  def load_products
    @products = Product.unscoped
    %i[internal_memory model brand min_price max_price ram].each do |filter_type|
      @products = @products.send("by_#{filter_type}", params[filter_type]) if params[filter_type].present?
    end
    @products = @products.order(params[:sort_by]) if params[:sort_by].present?
  end

  def load_product
    @product = Product.find_by_id(params[:id]).decorate
  end

  def filter_options
    options = {}
    %i[brand internal_memory ram].each do |filter_type|
      next if params[:filter][filter_type].blank?

      value = params[:filter][filter_type].reject(&:blank?).join(',')
      options[filter_type] = value unless value.blank?
    end
    %i[min_price max_price sort_by].each do |filter_type|
      options[filter_type] = params[:filter][filter_type] if params[:filter][filter_type].present?
    end
    options
  end
end
