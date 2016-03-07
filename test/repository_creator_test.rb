require 'pry'
require 'minitest/autorun'
require_relative '../lib/repository_creator'

class RepositoryCreatorTest < Minitest::Test

  def test_instance_exists
    skip
    creator = RepositoryCreator.new("")

    assert_equal RepositoryCreator, creator.class
  end


end
