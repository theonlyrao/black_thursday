require 'pry'
require_relative 'repository_methods'
require_relative 'sales_engine'
require_relative 'transaction'

class TransactionRepository

  attr_reader :sales_engine_instance

  include RepositoryMethods

  def initialize
  end

  def from_csv(filepath)
    for_sales_engine = { transactions: filepath }
    SalesEngine.from_csv(for_sales_engine, self)
  end

  def self.send_csv_contents_to_repo(transaction_hash, transaction_repo_instance, sales_engine_instance)
    if transaction_repo_instance.nil?
      transaction_repo = TransactionRepository.new
      transaction_repo.create_transaction_items(transaction_hash, sales_engine_instance)
      return transaction_repo
    else
      transaction_repo_instance.create_transaction_items(transaction_hash, sales_engine_instance)
      return transaction_repo_instance
    end
  end

  def inspect
    "TransactionRepo with #{@things.count} Transactions"
  end

  def create_transaction_items(transaction_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
    @things = transaction_array.map do |hash_of_transaction_info|
      Transaction.new(hash_of_transaction_info, sales_engine_instance)
    end
  end

end
