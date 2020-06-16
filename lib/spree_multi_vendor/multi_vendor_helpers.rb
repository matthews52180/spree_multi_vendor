module SpreeMultiVendor
  module MultiVendorHelpers
    include ::Spree::ProductsHelper
    include ::Spree::FrontendHelper

    def cache_key_for_vendor_products
      count = @products.count
      max_updated_at = (@products.maximum(:updated_at) || Date.today).to_s(:number)
      products_cache_keys = "spree/vendor-#{@vendor.slug}/products/all-#{params[:page]}-#{params[:sort_by]}-#{max_updated_at}-#{count}"
      (common_product_cache_keys + [products_cache_keys]).compact.join('/')
    end

    def filtering_params
      static_filters = %w(keywords price sort_by vendors)

      available_option_types.map(&:filter_param).concat(static_filters)
    end
  end
end 
