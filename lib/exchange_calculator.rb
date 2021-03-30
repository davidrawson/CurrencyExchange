require "date"

# Public: Provides exchange rate between two currencies on specific date
class ExchangeCalculator

  # Public: Initiakize an instance
  #
  # base_currency - string code for the 'home' currency
  # rates - the rates between currencies separated by dates
  def initialize(base_currency, rates)
    @base_currency = base_currency
    @rates = rates
  end

  # Public: Calculates the exchange rate on a specific date
  #
  # date - date object for the rate
  # from_currency - string of starting currency 
  # to_currency - string of target currency
  #
  # Returns float of exchange rate from start to target currency
  def calculate(date, from_currency, to_currency)
    date_string = date.strftime("%Y-%m-%d")
    validate_currencies(from_currency, to_currency, date_string)
    validate_date(date_string)

    return base_currency_to_to_currency(date_string, to_currency).to_f if from_currency == @base_currency
    return from_currency_to_base_currency(date_string, from_currency).to_f if to_currency == @base_currency
    from_currency_to_to_currency(date, from_currency, to_currency).to_f
  end

  # Public: Ensure the currencies provided are supported
  #
  # from_currency - string of starting currency 
  # to_currency - string of target currency
  # date_string - string of date of exchange
  #
  # Raises exception if either currency is not in the rates hash or not the base currency
  def validate_currencies(from_currency, to_currency, date_string)
    currencies = @rates[date_string]

    raise "#{from_currency} is not currently supported" unless currencies.key?(from_currency) || from_currency == @base_currency
    raise "#{to_currency} is not currently supported" unless currencies.key?(to_currency) || to_currency == @base_currency
  end

  # Public: Ensure the given date is in the rates hash
  #
  # date_string - string representation of the date
  #
  # Raises an exception if the date is not found inthe hash
  def validate_date(date_string)
    raise "No exchange rates found for the given date" unless @rates.key?(date_string)
  end

  # Public: Provide the exchange rate between the two currencies
  #
  # date - string representation of the date of exchange
  # to_currency - string of target currency
  #
  # Returns a float of the exchange rate on that date
  def base_currency_to_to_currency(date, to_currency)
    @rates[date][to_currency]
  end

  # Public: Provide the exchange rate between the two currencies
  #
  # date - string representation of the date of exchange
  # from_currency - string of starting currency 
  #
  # Returns a float of the exchange rate on that date
  def from_currency_to_base_currency(date, from_currency)
    1 / @rates[date][from_currency]
  end

  # Public: Provide the exchange rate between the two currencies
  #
  # date - string representation of the date of exchange
  # from_currency - string of starting currency 
  # to_currency - string of target currency
  #
  # Returns a float of the exchange rate on that date
  def from_currency_to_to_currency(date, from_currency, to_currency)
    @rates[date][to_currency] / @rates[date][from_currency]
  end
end
