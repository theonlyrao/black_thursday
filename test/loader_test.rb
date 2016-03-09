require 'pry'
require 'csv'
require 'minitest/autorun'
require_relative '../lib/loader'
require_relative '../lib/sales_engine'

class LoaderTest < Minitest::Test

  def test_loader_can_take_string_and_create_one_csv_objects
    se = SalesEngine.from_csv(:transactions => "./data/fixtures/transaction_stub.csv")

    assert_equal 664, se.transactions.all.count
  end

  def test_loader_can_take_hash_and_create_many_csv_objects
  end
end
