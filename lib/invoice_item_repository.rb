require 'pry'
require_relative 'repository_methods'
require_relative 'repository_creator'

class InvoiceItemRepository

  def from_csv(filepath)
    RepositoryCreator.new(filepath)
  end

end
