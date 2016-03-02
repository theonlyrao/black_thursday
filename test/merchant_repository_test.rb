require_relative 'test_helper_2'
require 'minitest/autorun'
require_relative 'merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @test_helper = TestHelper2.new
    @merchants = @test_helper.array_of_merchants
    @merchant_repository = MerchantRepository.new(@merchants)
  end

  def test_all_returns_array_of_all_Merchant_instances
    
  end

  # def test_find_by_id_returns_nil
  # end
  #
  # def test_find_all_returns_instances_of_Merchant
  # end
  #
  # find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
  # find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive


end
