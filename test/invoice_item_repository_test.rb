require 'pry'
require 'minitest/autorun'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @ir = InvoiceItemRepository.new
    @ir.from_csv("./data/fixtures/invoice_items_stub.csv")
  end
  
  def test_can_create_new_instance
    assert_equal InvoiceItemRepository, @ir.class
  end

  def test_this_repo_doenst_know_se_before_from_csv
    repo = InvoiceItemRepository.new

    refute repo.sales_engine_instance
  end

  def test_this_repo_does_know_se_after_from_csv
    engine = @ir.sales_engine_instance

    assert_equal SalesEngine, engine.class
  end

  def test_all_returns_all_invoice_item_instances
    all_test = @ir.all

    assert_equal 2519, all_test.count
    assert_equal InvoiceItem, all_test.first.class
  end

  def test_find_by_id_returns_nil
    find_nil = @ir.find_by_id(99999)

    refute find_nil
  end

  def test_find_by_id_returns_item_with_matching_id
    finder = @ir.find_by_id(14)

    assert_equal InvoiceItem, finder.class
    assert_equal 14, finder.id
  end

  def test_find_all_by_item_id_returns_empty_array
    finder = @ir.find_all_by_item_id(2)

    assert_equal [], finder
  end

  def test_find_all_by_item_id_returns_invoices
    finder = @ir.find_all_by_item_id(263563764)

    assert_equal 7, finder.first.id
  end

  def test_find_all_by_invoice_id_returns_empty_array
    finder = @ir.find_all_by_invoice_id(2342525)

    assert_equal [], finder
  end

  def test_find_all_by_invoice_id_returns_invoices
    finder = @ir.find_all_by_invoice_id(2)

    assert_equal 4, finder.count
  end

end
