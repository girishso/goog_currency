# GoogCurrency

A simple Ruby interface for currency conversion using Google API. Uses http://www.google.com/ig/calculator?hl=en&q=100USD=?INR

Current version: 0.0.2

## Installation

Add this line to your application's Gemfile:

    gem 'goog_currency'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goog_currency

## Usage

Sample usage

    usd = GoogCurrency.usd_to_inr(1)
    gbp = GoogCurrency.usd_to_gbp(1)

Throws GoogCurrency::Exception in case of any error.

Throws GoogCurrency::NoMethodException if conversion method syntax is invalid.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence
Copyright (c) 2013 Girish Sonawane

MIT License
