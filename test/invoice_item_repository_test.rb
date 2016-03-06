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

end
