JmeterApi
======

JmeterApi, an automated administrative Wrapper for Jmeter on your Linux and Unix systems, performs
administrative tasks (such as manage projects, keep track on runs) based on a centralized specification.


Installation
------------

Generally, you need the following things installed:

* A supported Ruby version. Ruby 1.8.7, and 1.9.2 are fully supported
  (with a handful of known issues under 1.9.2); Other versions of Ruby
  are used at your own risk, and Ruby 1.8.6, 1.9.0, and 1.9.1 are not
  recommended for compatibility reasons.

* The Ruby OpenSSL library.  For some reason, this often isn't included
  in the main ruby distributions.  You can test for it by running
  'ruby -ropenssl -e "puts :yep"'.  If that errors out, you're missing the
  library.

  If your distribution doesn't come with the necessary library (e.g., on Debian
  and Ubuntu you need to install libopenssl-ruby), then you'll probably have to
  compile Ruby yourself, since it's part of the standard library and not
  available separately.  You could probably just compile and install that one
  library, though.

License
-------

See LICENSE file.

Support
-------

Please log tickets and issues at a.heumaier@metaways.de