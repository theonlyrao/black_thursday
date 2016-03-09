require 'pry'
require_relative 'repository_methods'
require_relative 'sales_engine'
require_relative 'transaction'

class TransactionRepository

  attr_reader :sales_engine_instance

  include RepositoryMethods

  def initialize
    @things = []
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    transactions = contents.map do |row|
      row.to_h
    end
    create_transaction_items(transactions)
  end

  def inspect
    "TransactionRepo with #{@things.count} Transactions"
  end

  def create_transaction_items(transaction_array, sales_engine_instance = nil)
    @sales_engine_instance = sales_engine_instance
    @things = transaction_array.map do |hash_of_transaction_info|
      Transaction.new(hash_of_transaction_info, sales_engine_instance)
    end
    unless sales_engine_instance.nil?
      @sales_engine_instance.transactions = self
    end
  end

end
