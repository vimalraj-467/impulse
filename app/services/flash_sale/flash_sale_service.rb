# frozen_string_literal: true

module Services
  module FlashSale
    module FlashSaleService
      module_function

      def create(flash_sale_dto)
        flash_sale = ::FlashSale.new(flash_sale_dto)

        errors, flash_sale = Platform::Utils::DbUtils.save(flash_sale)

        raise FlashSaleNotCreatedException.new('Flash sale not created', errors) if errors

        schedule_sale_task(flash_sale)

        flash_sale
      end

      def schedule_sale_task(flash_sale)
        id = flash_sale['_id'].to_s

        scheduled_at = flash_sale['schedule_at'] / 1000.0

        Platform::Scheduler::Sale::SaleWorker.perform_async(id, scheduled_at)
      end

      def get(id)
        flash_sale = ::FlashSale.find(id)

        raise NotFoundException if flash_sale.nil?

        flash_sale
      end

      def get_upcoming(days = 2)
        current_timestamp = Time.now.to_i * 1000

        days_in_ms = days * 24 * 60 * 60 * 1000

        ::FlashSale.where(schedule_at: { '$lt' => current_timestamp + days_in_ms }).desc(:schedule_at).limit(10)
      end

      def delete(id)
        flash_sale = get(id)

        flash_sale.delete
      end

      def update(id, update_dto)
        flash_sale = get(id)

        flash_sale.update_attributes!(update_dto)
      end

      def search(query_text)
        query = {
          query: {
            multi_match: {
              query: query_text,
              fields: %w[name description]
            }
          }
        }

        query_results = Platform::Search::ElasticSearchHelper.instance.search('subscribers', query)

        query_results['hits']['hits'].each.map { |hit| hit['_source'] }
      end
    end
  end
end
