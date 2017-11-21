RbNaCl::Libsodium
=================
[![Gem Version](https://badge.fury.io/rb/rbnacl-libsodium.svg)](http://badge.fury.io/rb/rbnacl-libsodium)
[![Build Status](https://travis-ci.org/cryptosphere/rbnacl-libsodium.svg?branch=master)](https://travis-ci.org/cryptosphere/rbnacl-libsodium)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/cryptosphere/rbnacl-libsodium/blob/master/LICENSE.txt)

[RbNaCl] is a Ruby wrapper for [libsodium], a portable version of the Networking and
Cryptography library ([NaCl]) created by Daniel J. Bernstein.

tl;dr: it's one of the best crypto libraries around.

rbnacl-libsodium packages the libsodium library as a Ruby Gem so you don't have
to worry about installing it through system packages. It builds just like a
native extension, but since RbNaCl is implemented with FFI, works on JRuby too!

[RbNaCl]: https://github.com/cryptosphere/rbnacl
[libsodium]: https://github.com/jedisct1/libsodium
[NaCl]: http://nacl.cr.yp.to/

## Installation

Add this line to your application's Gemfile:

    gem 'rbnacl-libsodium'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbnacl-libsodium

## Usage

    require 'rbnacl/libsodium'

will tweak search path allowing `rbnacl` to find bundled `libsodium`
