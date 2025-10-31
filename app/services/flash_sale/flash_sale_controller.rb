class FlashSaleController < ImpulseController
  get "/:name" do |name|
    flash_sale = FlashSale.where(name: name).first
    if flash_sale.nil?
      status 404
      return "Flash sale not found"
    end
    flash_sale.to_json
  end
end
