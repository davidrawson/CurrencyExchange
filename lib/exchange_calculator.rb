require_relative "reader_factory"
require "date"

class ExchangeCalculator

  attr_reader :file_path, :base_currency, :rates

  def initialize(file_path, base_currency)
    @file_path = file_path
    @base_currency = base_currency
    @rates = ReaderFactory.new.create_reader(@file_path).read
  end

  def calculate(date, from_currency, to_currency)
    date_string = date.strftime("%Y-%m-%d")
    validate_currencies(from_currency, to_currency)
    validate_date(date_string)

    return base_currency_to_to_currency(date_string, to_currency).to_f if from_currency == @base_currency
    return from_currency_to_base_currency(date_string, from_currency).to_f if to_currency == @base_currency
  end

  def validate_currencies(from_currency, to_currency)
    raise "One of the currencies is not currently supported" if from_currency != @base_currency && to_currency != @base_currency
  end

  def validate_date(date_string)
    raise "No exchange rates found for the given date" unless @rates.key?(date_string)
  end

  def base_currency_to_to_currency(date, to_currency)
    get_rate(date, to_currency)
  end

  def from_currency_to_base_currency(date, from_currency)
    1 / get_rate(date, from_currency)
  end

  def get_rate(date, currency)
    @rates[date][currency]
  end
end
