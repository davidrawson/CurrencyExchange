require "exchange_calculator"
require "reader_factory"

module CurrencyExchange
    @file_path = "./data/eurofxref-hist-90d.json"
    @base_currency = "EUR"

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    # TODO: calculate and return rate
    ExchangeCalculator.new(@file_path, @base_currency).calculate(date, from_currency, to_currency)
  end
end
