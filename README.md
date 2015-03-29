![Proxi Clean Career Destroying Logo](http://i.imgur.com/eH4PWSe.png)

# ProxiClean

## What is proxi_clean?

A simple utility for checking if an http proxy works or not.  If you deal with huge lists of proxies and need to clean out the dead or non-functional ones, this might help you.

## How does it work?
Using the power of oxygen `proxi_clean` will make a call to the [realip.info](http://www.realip.info/api/p/realip.php) API using `RestClient` and determine it's unproxied public IP.  When checking if a proxy is valid or not `proxi_clean` reconfigures `RestClient` to use the proxy you provide and confirms that realip returns an IP address that does NOT match your unproxied public IP.

If anything goes wrong we blindly assume the proxy is no good.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'proxi_clean'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install proxi_clean`

## Usage

Easy! The API has 1 useful public method: `works?`. Just create a `client` and start checking proxies.

```ruby
2.2.1 :005 > client = ProxiClean::Client.new
 => #<ProxiClean::Client:0x007fa149e78b18 @public_ip="47.202.47.103">
2.2.1 :006 > client.works? 'https://124.88.67.13:843'
 => true
2.2.1 :007 > client.works? 'https://NOT-GONNA-WORK.com:47'
 => false
```

## Contributing

1. Fork it ( https://github.com/mariozig/proxi_clean/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
