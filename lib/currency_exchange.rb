require "exchange_calculator"
require "reader_factory"

# Public: Module to get exchange rate between two currencies
module CurrencyExchange
  @file_path = "./data/eurofxref-hist-90d.json"
  @base_currency = "EUR"

  # Public: returns the rate between two currencies on the argument date
  #
  # date - date object for the rate
  # from_currency - starting currency as a string
  # to_currency - target currrency as a string
  #
  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    rates = ReaderFactory.new.create_reader(@file_path).read
    ExchangeCalculator.new(@base_currency, rates).calculate(date, from_currency, to_currency)
  end
end
