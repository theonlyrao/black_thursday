require 'pry'
require 'minitest/autorun'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @cr = CustomerRepository.new
    @cr.from_csv("./data/customers.csv")
  end

  def test_can_create_new_instance
    assert_equal CustomerRepository, @cr.class
  end

  def test_this_repo_doenst_know_se_before_from_csv
    repo = CustomerRepository.new

    refute repo.sales_engine_instance
  end

  def test_all_returns_all_customer_instances
    all_test = @cr.all

    assert_equal 1000, all_test.count
    assert_equal Customer, all_test.first.class
  end

  def test_find_by_id_returns_nil
    find_nil = @cr.find_by_id(99999)

    refute find_nil
  end

  def test_find_by_id_returns_item_with_matching_id
    finder = @cr.find_by_id(14)

    assert_equal Customer, finder.class
    assert_equal 14, finder.id
  end

  def test_find_all_by_first_name_returns_empty_array
    finder = @cr.find_all_by_first_name("sdlfkjsf")

    assert_equal [], finder
  end

  def test_find_all_by_first_name_returns_customers
    finder = @cr.find_all_by_first_name("mi")

    assert_equal 36, finder.count
  end

  def test_find_all_by_last_name_returns_empty_array
    finder = @cr.find_all_by_last_name("slkjdflkfsj")

    assert_equal [], finder
  end

  def test_find_all_by_last_name_returns_customers
    finder = @cr.find_all_by_last_name("por")

    assert_equal 4, finder.count
  end

end
