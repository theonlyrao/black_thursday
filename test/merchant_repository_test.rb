require 'minitest/autorun'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new
    @merchant_repository.from_csv("./data/merchants.csv")
  end

  def test_all_returns_array_of_all_Merchant_instances
    assert_equal Array, @merchant_repository.all.class
    assert_equal 475, @merchant_repository.all.count
    assert_equal "Shopin1901", @merchant_repository.all[0].name
  end

  def test_find_by_id_returns_nil
    assert_equal nil, @merchant_repository.find_by_id(72)
  end

  def test_find_by_id_returns_instances_of_Merchant
    assert_equal "ZazaBoutiqueShop", @merchant_repository.find_by_id(12334299).name
  end

  def test_find_by_name_returns_nil_when_no_match_is_found
    assert_equal nil, @merchant_repository.find_by_name("Ashwin")
  end

  def test_find_by_name_returns_an_instance_of_Merchant
    assert_equal 12334174, @merchant_repository.find_by_name("Uniford").id
  end

  def test_find_all_by_name_returns_an_empty_array
    assert_equal [], @merchant_repository.find_all_by_name("nobody")
  end

  def test_find_all_by_name_returns_one_plus_matches_that_contain_fragment
    assert_equal 228, @merchant_repository.find_all_by_name("l").count
  end

end
