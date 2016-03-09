require 'pry'
require 'csv'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class Loader

  def initialize(se = nil, filepaths)
    @se = se
    split_filepaths(filepaths)
  end

  def split_filepaths(filepaths)
    if filepaths.keys.include? (:items)
      create_item_repo(filepaths[:items])
    end
    if filepaths.keys.include? (:merchants)
      create_merchant_repo(filepaths[:merchants])
    end
    if filepaths.keys.include? (:invoices)
      create_invoice_repo(filepaths[:invoices])
    end
    if filepaths.keys.include? (:invoice_items)
      create_invoice_item_repo(filepaths[:invoice_items])
    end
    if filepaths.keys.include? (:transactions)
      create_transaction_repo(filepaths[:transactions])
    end
    if filepaths.keys.include? (:customers)
      create_customer_repo(filepaths[:customers])
    end
  end

  def parse_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    things = contents.map do |row|
      row.to_h
    end
    things
  end

  def create_item_repo(filepath)
    item_csv = parse_csv(filepath)
    item_repo = ItemRepository.new
    item_repo.create_item_items(item_csv, @se)
  end

  def create_merchant_repo(filepath)
    merchant_csv = parse_csv(filepath)
    merchant_repo = MerchantRepository.new
    merchant_repo.create_merchant_items(merchant_csv, @se)
  end

  def create_invoice_repo(filepath)
    invoice_csv = parse_csv(filepath)
    invoice_repo = InvoiceRepository.new
    invoice_repo.create_invoice_items(invoice_csv, @se)
  end

  def create_invoice_item_repo(filepath)
    invoice_item_csv = parse_csv(filepath)
    invoice_item_repo = InvoiceItemRepository.new
    invoice_item_repo.create_invoice_item_items(invoice_item_csv, @se)
  end

  def create_transaction_repo(filepath)
    transaction_csv = parse_csv(filepath)
    transaction_repo = TransactionRepository.new
    transaction_repo.create_transaction_items(transaction_csv, @se)
  end

  def create_customer_repo(filepath)
    customer_csv = parse_csv(filepath)
    customer_repo = CustomerRepository.new
    customer_repo.create_customer_items(customer_csv, @se)
  end

end
