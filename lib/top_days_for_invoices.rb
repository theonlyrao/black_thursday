module TopDaysForInvoices

  def top_days_by_invoice_count
    # a list of dates on which invoices were created
    all_dates = @sales_engine_instance.invoices.all.map do |invoice|
      invoice.created_at
    end.uniq

    # pairing dates with number of invoices created on that date
    # in an array element
    dates_and_num_invoices = all_dates.map do |date|
      [date, invoices_created_on_date(date)]
    end

    # turing the dates in the array into days of week
    days_and_num_invoices = dates_and_num_invoices.map do |date, num|
      [turn_date_into_day_of_week(date), num]
    end

    # get the hash thing with day as key and total invoices as value
    days_hash = Hash.new
    days_and_num_invoices.each do |day, num|
      if days_hash.keys.include?(day)
        days_hash[day] += num
      else
        days_hash[day] = num
      end
    end
    days_hash

    # now find average number of invoices per day
    avg_invoices_per_day = days_hash.values.reduce(:+)/7

    # now find standard deviation
    sd = standard_deviation(days_hash.values, avg_invoices_per_day)

    # find the cutoff for high
    high_invoices = avg_invoices_per_day + sd

    # now find the days
    top_days_by_invoice_count = []
    days_hash.each do |day, num_invoices|
      top_days_by_invoice_count << day if num_invoices > high_invoices
    end

    top_days_by_invoice_count
  end

  def invoices_created_on_date(date)
    invoices = @sales_engine_instance.invoices
    days_invoices = invoices.all.find_all do |invoice|
      invoice.created_at == date
    end

    num_invoices_created_on_date = days_invoices.count
    num_invoices_created_on_date
  end

  def turn_date_into_day_of_week(date)
    days_hash = { 0 => "Sunday", 1 => "Monday", 2 => "Tuesday",
                  3 => "Wednesday", 4 => "Thursday",
                  5 => "Friday", 6 => "Saturday" }
    day = days_hash[date.wday]
    day
  end

end
