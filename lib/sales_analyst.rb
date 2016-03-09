require 'pry'
require 'bigdecimal'
require 'time'
require_relative 'average_num_of_things_methods'
require_relative 'merchant_counts_methods'
require_relative 'top_days_for_invoices'
require_relative 'price_methods'

class SalesAnalyst

  include AverageNumOfThingsMethods
  # avg num of things has methods relating to average items and
  # invoices per merchant

  include MerchantCountsMethods
  # merchant counts methods calculate which merchants have
  # high or low numbers of items and invoices

  include TopDaysForInvoices

  include PriceMethods

  def initialize(sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def standard_deviation(sample, sample_mean)
    differences = sample.map do |datapoint|
      (datapoint - sample_mean) ** 2
    end.reduce(:+)

    divisor = sample.count - 1

    raw_standard_deviation = Math.sqrt(differences/divisor)

    standard_deviation = BigDecimal.new(raw_standard_deviation, 3).to_f
    standard_deviation
  end

  def golden_items
    average = average_price_per_item
    deviation = (2 * average_price_per_item_standard_deviation)
    high_price = average + deviation

    golden_items = @sales_engine_instance.items.all.find_all do |item|
      item.unit_price > high_price
    end
    golden_items
  end

  def invoice_status(status)
    invoices = @sales_engine_instance.invoices
    total_invoices = invoices.all.count

    num_invoices = invoices.find_all_by_status(status).count

    invoice_status = (100 * num_invoices.to_f)/total_invoices.to_f
    invoice_status.round(2)
  end
end
