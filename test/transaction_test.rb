require 'minitest/autorun'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test

  def test_transaction_instance_exists
    t = Transaction.new({:id => 6,
                          :invoice_id => 3,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => "2012-03-27 14:54:09 UTC",
                          :updated_at => "2012-03-27 14:54:09 UTC"
                        })

    assert_equal Transaction, t.class
  end

  def test_transaction_knows_its_invoices
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions => "./data/transactions.csv",
        :customers => "./data/customers.csv"
      })

      transaction = se.transactions.find_by_id(40)

      invoice = transaction.invoice

      assert_equal 14, invoice.id
  end

end
