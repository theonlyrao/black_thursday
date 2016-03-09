require 'pry'
require 'minitest/autorun'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @tr = TransactionRepository.new
    @tr.from_csv("./data/fixtures/transaction_stub.csv")
  end

  def test_can_create_new_instance
    assert_equal TransactionRepository, @tr.class
  end

  def test_this_repo_doenst_know_se_before_from_csv
    repo = TransactionRepository.new

    refute repo.sales_engine_instance
  end

  def test_all_returns_all_invoice_item_instances
    all_test = @tr.all

    assert_equal 664, all_test.count
    assert_equal Transaction, all_test.first.class
  end

  def test_find_by_id_returns_nil
    find_nil = @tr.find_by_id(99999)

    refute find_nil
  end

  def test_find_by_id_returns_item_with_matching_id
    finder = @tr.find_by_id(14)

    assert_equal Transaction, finder.class
    assert_equal 14, finder.id
  end

  def test_find_all_by_invoice_id_returns_empty_array
    finder = @tr.find_all_by_invoice_id(2)

    assert_equal [], finder
  end

  def test_find_all_by_invoice_id_returns_invoices
    finder = @tr.find_all_by_invoice_id(3560)

    assert_equal 14, finder.first.id
  end

  def test_find_all_by_credit_returns_empty_array
    finder = @tr.find_all_by_credit_card_number(40558132)

    assert_equal [], finder
  end

  def test_find_all_by_credit_returns_invoices
    finder = @tr.find_all_by_credit_card_number(4055813232766404)

    assert_equal 18, finder.first.id
  end

  def test_find_all_by_result_empty_array
    finder = @tr.find_all_by_result(:happy)

    assert_equal [], finder
  end

  def test_find_all_by_result_returns_invoices
    finder = @tr.find_all_by_result("failed")

    assert_equal 120, finder.count
  end

end
