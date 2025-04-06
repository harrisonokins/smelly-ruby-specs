# Smelly Specs

## About
This repo contains a series of tests to illustrate common scenarios that prevent specs from run running effectively (or running at all).

## Installation
1. Install [`rbenv`](https://github.com/rbenv/rbenv)
2. Run `rbenv install 3.4` to install the appropriate Ruby version
3. Clone this repo to a folder of your choice
4. Inside that folder, run `rbenv local 3.4` to set the local Ruby version
5. Run `bundle install` to install needed dependencies
6. Optionally run `gem install parallel_tests` (if you want to test parallelization)

## Usage
Individual tests are split between two folders:

1. `bad-tests` contains broken or malformed tests
2. `good-tests` contains a corollary set of "fixed" tests with identical names

To run any test, simply invoke them as a ruby script from your terminal:

```bash
# Run the broken and fixed timezone tests:
ruby bad-tests/timezone.rb
ruby good-test/timezone.rb

# Run tests in a random order
ruby bad-tests/order.rb --order=r
ruby good-tests/order.rb --order=r

# Run multiple test files in parallel
parallel_test bad-tests/factories.rb bad-tests/seeds.rb
parallel_test good-tests/factories.rb good-tests/seeds.rb
```
