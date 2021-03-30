# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.


# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'
require 'exchange_calculator'
require 'reader_factory'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
    @base_currency = "EUR"
    @file_path = "./data/eurofxref-hist-90d.json"
    @rates = ReaderFactory.new.create_reader(@file_path).read

    @test_rate = {"2021-02-28" => {"HUF" => 0.321, "ZAR" => 3.14159}}
    @invalid_file = "./data/eurofxref-hist-90d.yoga"
  end

  def test_calculate_to_base_currency
    correct_rate = 0.007763975155279502
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "EUR")
  end

  def test_calculate_from_base_currency
    correct_rate = 1290.52
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,10,02), "EUR", "KRW")
  end

  def test_calculate_from_and_to_currencies
    fixture = ExchangeCalculator.new(@base_currency, @test_rate)
    correct_rate = 9.786884735202491
    assert_equal correct_rate, fixture.from_currency_to_to_currency("2021-02-28", "HUF", "ZAR")
  end

  def test_valid_date_accepted
    fixture = ExchangeCalculator.new(@base_currency, @rates)
    assert_nil fixture.validate_date("2018-09-27")
  end

  def test_valid_currencies_accepted
    fixture = ExchangeCalculator.new(@base_currency, @rates)
    assert_nil fixture.validate_currencies("USD", "EUR", "2018-09-27")
  end

  # Exceptions
  def test_raise_exception_when_no_rates_for_date
    fixture = ExchangeCalculator.new(@base_currency, @rates)
    exception = assert_raise(RuntimeError) {fixture.validate_date("2018-09-29")}
    assert_equal "No exchange rates found for the given date", exception.message
  end

  def test_raise_exception_when_currency_not_supported
    fixture = ExchangeCalculator.new(@base_currency, @rates)
    exception = assert_raise(RuntimeError) {fixture.validate_currencies("YYY", "EUR", "2018-09-27")}
    assert_equal "YYY is not currently supported", exception.message

    exception = assert_raise(RuntimeError) {fixture.validate_currencies("EUR", "ZZZ", "2018-09-27")}
    assert_equal "ZZZ is not currently supported", exception.message
  end

  def test_raise_exception_when_file_extension_not_supported
    fixture = ReaderFactory.new
    exception = assert_raise(RuntimeError) { fixture.create_reader(@invalid_file) }
    assert_equal "File with extension .yoga does not have a corresponding Reader.", exception.message
  end
end
