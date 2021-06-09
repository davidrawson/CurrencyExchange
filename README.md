# Coding Challenge

Thank you for your interest in the Coding Challenge. This template is a barebones guide to get you started. Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

Setup is as per your instructions

1. Install gems:

```
bundle install
```

2. Run tests:

```
bundle exec ruby test/run_tests.rb
```

3. Start a console session & load the template library:

```
bundle exec irb -I lib -r ./lib/currency_exchange.rb
```

4. Calculate an exchange rate:

```
CurrencyExchange.rate(Date.new(2018, 09, 27), "EUR", "GBP")
```

5. Generate documentation:

```
yard doc --plugin yard-tomdoc
```

## Your Design Decisions

### First impressions

The file readers class(es) should implement an interface forcing certain things and maintain consistency. As Ruby doesn't utilise interfaces that idea was amended.

### Reader Factory

A factory seemed the best way to enable different file formats (such as xml) to be added in the future whilst maintaining consistency.
The Factory pattern should have an abstract or base class but I thought it was unncessary until a second file format was to be implemented.

### Class Responsibilities

The factory should just produce a reader.

The file reader should just read the file into the hash; they have no need to know of base currencies.

The base/home currency and the data filename is probably best declared in the main module, perhaps with getter and setter methods when other currencies and file formats are added.

The main CurrencyExchange module should call the factory to create the reader and parse to the hash; it is not the job of a calculator class.

The ExchangeCalculator calculates the exchange rate _and_ does the currency and date validation. There is a good argument for stripping the validation out to its own class, and I would have done had the class got any larger.

### Other Additions

Added e2mmap to the gemfile as it was required by irb. Unclear if this was an issue with my installation.

The TomDoc documentation has been added, though I couldn't get it to generate anything. Again, unclear if this was an issue with my installation.

### Next Steps

Whilst the test coverage for the calculations is reasonable, more tests could be added for the factory and reader.
The validation could be in a standalone class.
