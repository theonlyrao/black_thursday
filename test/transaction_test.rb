require 'minitest/autorun'
require_relative '../lib/transaction'

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

end
