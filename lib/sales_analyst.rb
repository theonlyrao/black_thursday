require 'pry'
require 'bigdecimal'
require 'time'
require_relative 'average_num_of_things_methods'
require_relative 'merchant_counts_methods'
require_relative 'top_days_for_invoices'

class SalesAnalyst

  include AverageNumOfThingsMethods
  # avg num of things has methods relating to average items and
  # invoices per merchant

  include MerchantCountsMethods
  # merchant counts methods calculate which merchants have
  # high or low numbers of items and invoices

  include TopDaysForInvoices

  def initialize(sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine_instance.merchants.find_by_id(merchant_id)

    merchants_items = merchant.items

    sum_of_prices_of_all_merchants_items = merchants_items.map do |item|
      item.unit_price
    end.reduce(:+).to_f

    num_merchants_items = merchants_items.count.to_f
    average_item_price_for_merchant = BigDecimal(sum_of_prices_of_all_merchants_items/num_merchants_items, 4)
  end

  def average_average_price_per_merchant

    all_merchant_ids = @sales_engine_instance.merchants.all.map do |merchant|
      merchant.id
    end

    total_number_merchants = BigDecimal(@sales_engine_instance.merchants.all.count)

    average_item_price_per_merchant = all_merchant_ids.map do |id|
      if @sales_engine_instance.merchants.find_by_id(id).items.count > 0
        result = average_item_price_for_merchant(id)
      else
        result = BigDecimal("0")
      end
      result
    end.reduce(:+)

    average_average_price_per_merchant = average_item_price_per_merchant/total_number_merchants
    average_average_price_per_merchant.truncate(2)
  end

  def average_price_per_item
    total_items = @sales_engine_instance.items.all.count.to_f
    total_of_prices_of_all_items = @sales_engine_instance.items.all.map do |item|
      item.unit_price
    end.reduce(:+)

    average_price_per_item = BigDecimal.new(total_of_prices_of_all_items/total_items, 3).to_f
    average_price_per_item
  end

  def average_price_per_item_standard_deviation
    average_price_per_item

    price_of_each_item = @sales_engine_instance.items.all.map do |item|
      item.unit_price
    end

    array_of_price_differences_from_mean = price_of_each_item.map do |price|
      price - average_price_per_item
    end

    sum_of_squares = array_of_price_differences_from_mean.map do |difference|
      difference ** 2
    end.reduce(:+)

    num_items = @sales_engine_instance.items.all.count - 1

    raw_standard_deviation = Math.sqrt(sum_of_squares/num_items)
    standard_deviation = BigDecimal.new(raw_standard_deviation, 3).to_f
    standard_deviation
  end

  def golden_items
    high_price = average_price_per_item + (2 * average_price_per_item_standard_deviation)
    golden_items = @sales_engine_instance.items.all.find_all do |item|
      item.unit_price > high_price
    end
    golden_items
  end

  def invoice_status(status)
    # get total number of invoices
    total_invoices = @sales_engine_instance.invoices.all.count
    # get number of invoices with relevant status
    num_invoices_with_status = @sales_engine_instance.invoices.find_all_by_status(status).count

    # divide relevant by total
    invoice_status = BigDecimal(100 * num_invoices_with_status)/BigDecimal(total_invoices)
    invoice_status.truncate(2).to_s("F").to_f
  end

end
