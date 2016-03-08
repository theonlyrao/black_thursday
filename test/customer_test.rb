require 'minitest/autorun'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_customer_instance_exists
    c = Customer.new({:id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => "2012-03-27 14:54:09 UTC",
                      :updated_at => "2012-03-27 14:54:09 UTC"
                        })

    assert_equal Customer, c.class
  end

end
