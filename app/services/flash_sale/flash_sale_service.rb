# frozen_string_literal: true

module Services
  module FlashSale
    module FlashSaleService
      def create_flash_sale(flash_sale_dto)
        flash_sale = ::FlashSale.new(flash_sale_dto)

        errors, flash_sale = Platform::Utils::DbUtils.save(flash_sale)

        raise FlashSaleNotCreatedException.new('Flash sale not created', errors) if errors

        flash_sale
      end
    end
  end
end
