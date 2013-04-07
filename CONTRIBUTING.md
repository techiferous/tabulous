# Contributing to Tabulous

If you have ideas, suggestions or problems, bring them up by opening an [issue on GitHub](https://github.com/techiferous/tabulous/issues).

If you have an idea for new behavior, please start a discussion before going to the trouble of coding up a solution since there might be a good reason why I left that behavior out.

Pull requests are welcome.  If you want your pull request to be more than a discussion starter but be a candidate for actually getting merged, please do the following:

* your code should be well-written and follow the style of the rest of the tabulous code
* you should write new specs for your code if existing specs do not offer good coverage
* you should make sure the specs pass in all versions of Rails 3.0 or later and Ruby 1.9 and 2.0

## Running Specs

Unfortunately, it's really difficult to get all of the tabulous specs running so I apologize for that.  I found it difficult to set up specs to easily test tabulous across various versions of Rails and Ruby at the same time.  The process for getting the specs up and running is documented in [spec/applications/README.md](spec/applications/README.md).

For instructions on how to run specs, run the default rake task in tabulous:

    rake
