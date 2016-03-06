require 'minitest/autorun'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:invoices => "./data/fixtures/invoice_stub.csv"})
  end

  def test_all_returns_array_of_all_invoice_instances
    invoice_array = @se.invoices.all

    assert_equal 99, invoice_array.count
  end

  def test_find_by_id_returns_nil_when_none_match
    invoice = @se.invoices.find_by_id(3249873249872474)

    assert_equal nil, invoice
  end

  def test_find_by_id_returns_nil_when_none_match
    invoice = @se.invoices.find_by_id(2)

    assert_equal Invoice, invoice.class
  end

  def test_find_all_by_status_when_nonense
    invoices = @se.invoices.find_all_by_status("happy")

    assert_equal [], invoices
  end

  def test_find_all_by_status
    invoices = @se.invoices.find_all_by_status(:pending)

    assert_equal 29, invoices.count
  end

  def test_find_all_by_customer_id_returns_nil_when_none
    invoices = @se.invoices.find_all_by_customer_id(82342342)

    assert_equal [], invoices
  end

  def test_find_all_by_customer_id
    invoices = @se.invoices.find_all_by_customer_id(8)

    assert_equal 2, invoices.count
  end
end
