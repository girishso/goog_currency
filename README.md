# GoogCurrency

Google finance provides currency conversion functionality. Integrated the scrapper to get conversion working.
Uses http://www.google.com/finance/converter?a=1&from=USD&to=INR

[![Build Status](https://travis-ci.org/girishso/goog_currency.png?branch=master)](https://travis-ci.org/girishso/goog_currency) [![Gem Version](https://badge.fury.io/rb/goog_currency.png)](http://badge.fury.io/rb/goog_currency)

## Installation

Add this line to your application's Gemfile:

    gem 'goog_currency'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goog_currency

## Usage

Sample usage

    rupees = GoogCurrency.usd_to_inr(1)
    pounds = GoogCurrency.usd_to_gbp(1)
    yen = GoogCurrency.gbp_to_jpy(1)

Throws GoogCurrency::Exception in case of any error.

Throws GoogCurrency::NoMethodException if conversion method syntax is invalid.

## Credits

[girishso](https://github.com/girishso) - Initial implementation

[pankajso](https://github.com/pankajso) - Ported to use Google Finance

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence
MIT License

This software is provided as is, use it your own risk.

Copyright (c) 2013 Girish Sonawane

