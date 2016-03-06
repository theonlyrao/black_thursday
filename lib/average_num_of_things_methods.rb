module AverageNumOfThingsMethods

    def average_num_of_things_per_merchant(thing)
      if thing == :invoices
        total_things = @sales_engine_instance.invoices.all.count.to_f
        digits = 4
      else
        total_things = @sales_engine_instance.items.all.count.to_f
        digits = 3
      end

      total_merchants = @sales_engine_instance.merchants.all.count.to_f

      average_things_per_merchant = BigDecimal.new(total_things/total_merchants, digits).to_f
      average_things_per_merchant
    end

    def average_invoices_per_merchant
      average_num_of_things_per_merchant(:invoices)
    end

    def average_items_per_merchant
      average_num_of_things_per_merchant(:items)
    end

    def average_num_of_things_per_merchant_standard_deviation(thing)
      if thing == :invoices
        num_things_per_merchant = @sales_engine_instance.merchants.all.map do |merchant|
          merchant.invoices.count
        end
      else
        num_things_per_merchant = @sales_engine_instance.merchants.all.map do |merchant|
          merchant.items.count
        end
      end

      differences = num_things_per_merchant.map do |num_items|
        num_items - average_num_of_things_per_merchant(thing)
      end

      square_diff = differences.map { |difference| difference ** 2}
      sum_of_squares = square_diff.reduce(:+)

      num_merchants = @sales_engine_instance.merchants.all.count.to_f
      divisor = num_merchants - 1

      raw_standard_deviation = Math.sqrt(sum_of_squares/divisor)
      standard_deviation = BigDecimal.new(raw_standard_deviation, 3).to_f
      standard_deviation
    end

    def average_items_per_merchant_standard_deviation
      average_num_of_things_per_merchant_standard_deviation(:items)
    end

    def average_invoices_per_merchant_standard_deviation
      average_num_of_things_per_merchant_standard_deviation(:invoices)
    end
end
