# frozen_string_literal: true

module Services
  module Order
    def create(order_dto)
      sale_key = "sale:#{order_dto[:sale_id]}"

      puts sale_key

      validate_inventory(sale_key)

      create_order(order_dto)
    end

    def validate_inventory(sale_key)
      success, result = Platform::Cache::RedisHelper.instance.get_and_decrement(sale_key)

      puts success
      puts result

      return unless success.zero?

      case result
      when -1
        raise InvalidSaleException, 'Sale not available'
      when -2
        raise InvalidSaleException, 'Sale is out of stock'
      else
        raise InvalidSaleException, 'Invalid saleå'
      end
    end

    def create_order(order_dto)
      order = ::Order.new({
                            'user_id' => order_dto['user_id'],
                            'sale_id' => order_dto['sale_id'],
                            'status' => 'DRAFT'
                          })

      errors, saved_order = Platform::Utils::DbUtils.save(order)

      raise SaleNotCreatedException('Sale not create', errors) if errors.present?

      saved_order
    end
  end
end
