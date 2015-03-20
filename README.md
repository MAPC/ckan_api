# CKAN

* http://github.com/apohllo/CKAN

## DESCRIPTION

'CKAN' is a Ruby client of the Comprehensive Knowledge Archive Network.

## FEATURES/PROBLEMS

* The project is in pre-alpha state.
* CKAN packages REST API wrapper.
* CKAN resources class.
* Query API for CKAN packages.

## SYNOPSIS

'CKAN' is a Ruby client for the Comprehensive Knowledge Archive Network. It
provides an object oriented interface for the repository based on the REST API
of CKAN.

## INSTALL

The gem is available at rubygems.org, so you can install it with:

    $ gem install ckan

## BASIC USAGE

```ruby
  require 'ckan'

  # Set the base API URL. The default is http://demo.ckan.org/api/3/.
  CKAN::API.api_url = "https://your.ckan.net/api/3/"

  # Get all CKAN packages, optionally limiting results
  packages = CKAN::Package.find
  packages = CKAN::Package.find(rows: 5)
  # => [#<CKAN::Package:01>, #<CKAN::Package:03fc564a07f7c3bcce4fd5d01cb4ca24>, #<CKAN::Package:05313fa4-bb70-46b5-867d-d33e6bc917b5>, #<CKAN::Package:103>, #<CKAN::Package:113214>,...]

  # Search for CKAN packages
  packages = CKAN::Package.find(tags: ["government", "weather"])
  # => [#<CKAN::Package:3dbae792-3443-4171-bb10-afb8759364c3>(,...)]

  # Get a package by ID. At present, #find always returns an array, so remember the `.first`
  # to get the record before doing anything with it.
  package = CKAN::Package.find(id: "3dbae792-3443-4171-bb10-afb8759364c3").first
  # => #<CKAN::Package:3dbae792-3443-4171-bb10-afb8759364c3>

  # Get package attributes. These are lazy-loaded through other calls
  # to the API, to minimize initial data transfer.
  package.name
  # => "smhi-open-data"

  # Get the package's resources
  package.resources
  # => [#<CKAN::Resource:2a09f74e-0750-4f1c-8f21-f286c601f675>()]
```

## LICENSE:
 
(The MIT License)

Copyright (c) 2010-2013 Aleksander Pohl

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## FEEDBACK

* mailto:apohllo@o2.pl

