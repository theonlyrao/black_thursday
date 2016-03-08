require 'pry'
require_relative 'repository_methods'
require_relative 'sales_engine'
require_relative 'customer'

class CustomerRepository

  attr_reader :sales_engine_instance

  include RepositoryMethods

  def initialize
  end

  def from_csv(filepath)
    for_sales_engine = { customers: filepath }
    SalesEngine.from_csv(for_sales_engine, self)
  end

  def self.send_csv_contents_to_repo(customer_hash, customer_repo_instance, sales_engine_instance)
    if customer_repo_instance.nil?
      customer_repo = CustomerRepository.new
      customer_repo.create_customers(customer_hash, sales_engine_instance)
      return customer_repo
    else
      customer_repo_instance.create_customers(customer_hash, sales_engine_instance)
      return customer_repo_instance
    end
  end

  def inspect
    "InvoiceItemRepo with #{@things.count} InvoiceItems"
  end

  def create_customers(customer_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
    @things = customer_array.map do |hash_of_customer_info|
      Customer.new(hash_of_customer_info, sales_engine_instance)
    end
  end

end
