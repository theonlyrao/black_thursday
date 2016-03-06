require_relative 'invoice'

module RepositoryMethods

    def all
      @things
    end

    def find_by_id(id)
      @things.find do |thing|
        thing.id == id
      end
    end

    def find_by_name(name)
      @things.find do |thing|
        thing.name == name
      end
    end

    def find_all_with_description(search_string)
      results = @things.find_all do |thing|
        thing.description.downcase.include?(search_string.downcase)
      end
    end

    def find_all_by_price(price)
      things = @things.find_all do |thing|
        thing.unit_price == price
      end
    end

    def find_all_by_price_in_range(range)
      things = @things.find_all do |thing|
        thing if thing.unit_price >= range.min && thing.unit_price <= range.max
      end
    end

    def find_all_by_thing_id(thing_id)
      thing_ids = @things.find_all do |thing|
        thing.thing_id == thing_id
      end
    end

    def find_by_name(name)
      @things.find do |thing|
        thing.name.downcase == name.downcase
      end
    end

    def find_all_by_name(search_string)
      @things.find_all do |thing|
        thing.name.downcase.include?(search_string)
      end
    end

    def find_all_by_status(status)
      @things.find_all do |thing|
        thing.status == status
      end
    end

    def find_all_by_merchant_id(merchant_id)
      merchant_ids = @things.find_all do |thing|
        thing.merchant_id == merchant_id
      end
    end

    def find_all_by_customer_id(customer_id)
      things = @things.find_all do |thing|
        thing.customer_id == customer_id
      end
    end

end
