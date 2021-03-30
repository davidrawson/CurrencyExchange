require "date"

class ExchangeCalculator

  attr_reader :base_currency, :rates

  def initialize(base_currency, rates)
    @base_currency = base_currency
    @rates = rates
  end

  def calculate(date, from_currency, to_currency)
    date_string = date.strftime("%Y-%m-%d")
    validate_currencies(from_currency, to_currency, date_string)
    validate_date(date_string)

    return base_currency_to_to_currency(date_string, to_currency).to_f if from_currency == @base_currency
    return from_currency_to_base_currency(date_string, from_currency).to_f if to_currency == @base_currency
  end

  def validate_currencies(from_currency, to_currency, date_string)
    currencies = @rates[date_string]

    raise "#{from_currency} is not currently supported" unless currencies.key?(from_currency) || from_currency == @base_currency
    raise "#{to_currency} is not currently supported" unless currencies.key?(to_currency) || to_currency == @base_currency
  end

  def validate_date(date_string)
    raise "No exchange rates found for the given date" unless @rates.key?(date_string)
  end

  def base_currency_to_to_currency(date, to_currency)
    @rates[date][to_currency]
  end

  def from_currency_to_base_currency(date, from_currency)
    1 / @rates[date][from_currency]
  end

  def from_currency_to_to_currency(date, from_currency, to_currency)
    @rates[date][to_currency] / @rates[date][from_currency]
  end
end
