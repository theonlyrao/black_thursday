require_relative '../lib/merchant'

class TestHelper2
  # def array_of_merchants
	# 	time = Time.now
	# 	[Merchant.new({
  #     :id          => "123456789",
  #     :name        => "Bill"}),
	#   Merchant.new({
  #     :id          => "987654321",
  #     :name        => "Jimmy"}),
	# 	Merchant.new({
	# 	  :id          => "555555555",
	# 	  :name        => "SparklePantsLarry"})]
	# end
  def array_of_merchants
		[({
      :id          => "123456789",
      :name        => "Bill"}),
	  ({
      :id          => "987654321",
      :name        => "Jimmy"}),
		({
		  :id          => "555555555",
		  :name        => "SparklePantsLarry"})]
	end

end
