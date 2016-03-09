require 'pry'
require_relative 'repository_methods'
require_relative 'sales_engine'
require_relative 'customer'

class CustomerRepository

  attr_reader :sales_engine_instance

  include RepositoryMethods

  def initialize
    @things = []
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    customers = contents.map do |row|
      row.to_h
    end
    create_customer_items(customers)
  end

  def inspect
    "CustomerRepo with #{@things.count} Customers"
  end

  def create_customer_items(customer_array, sales_engine_instance = nil)
    @sales_engine_instance = sales_engine_instance
    @things = customer_array.map do |hash_of_customer_info|
      Customer.new(hash_of_customer_info, sales_engine_instance)
    end
    unless @sales_engine_instance.nil?
      @sales_engine_instance.customers = self
    end
  end

end
