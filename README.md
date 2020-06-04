# Applitools Hackathon 2020

This project contains 4 testing frameworks centred around finding visual and functional bugs in Applitool's hackathon
demo application.

Each framework is written in Ruby using
* RSpec
* Selenium Webdriver

## Running Tests

### Ruby
Ruby must be installed to run these tests.  They were written on a Windows 10 machine using `2.6.6p146 (2020-03-31
 revision 67876) [x64-mingw32]`.

### Bundler
Bundler must be installed to run these tests. You can find installation instructions at [bundler.io](https://bundler.io/)

In order to run a set of tests, navigate to the root folder of specific framework you want to run in
a terminal, e.g.
```
cd hackathon2020/ModernTestsV1
```

From there, make sure all the necessary Ruby gems are installed by running
```bundle install```

__As each framework has its own Gemfile, you will need to `bundle install` for each framework that you want to run.
This is necessary due to differing Selenium versions required for Traditional and Modern approaches.__

### Environmment Variables

Certain environment variables need to be set in order to run the tests properly:

How these are set differs between desktop operating systems.  On Windows these can be set using e.g.

```set BROWSER=chrome```

I believe on Mac and Linux you would either export the variables in the terminal, or prepend them to the command
you're trying to run e.g.

```BROWSER=chrome rspec```

#### Traditional

##### BROWSER

The traditional tests require a specific browser to be chosen, which will then be used to run the tests in. This mirrors
how the tests would be set up on a CI server, by having multiple different builds run in succession, each specifying
a different browser.

#### Modern

##### APPLITOOLS_API_KEY

Set this to the API key that Applitools provides you with.

### Test Execution

From the root directory of the specific framework use the command `rspec`.  Sometimes this may need to be 
`bundle exec rspec`, but I'm unsure what circumstances this is necessary in.  If rspec doesn't work, give the second
command a try.

## Deviations

### Log files
I've stuck closely to the assignment, but deviated slightly when it comes to the log files created during the
traditional tests. I decided not to log element IDs during those, as it's just messy and something I would never do
in a framework. The name of the test suite and case should be enough to tell anyone reading the test results
what is likely to be wrong.

I included `allure reports` in order to make debugging the traditional tests a little bit easier.  They can be a little
tricky to get running, but they're far more useful than anything in the provided log text files. No reports are in
version control, but you can generate and open them if you're familiar enough with allure reports.

I wont include instructions on how to use allure, as it's quite in depth -- requiring multiple commands and tools -- 
and not necessary to judge this entry.

### Bugs potentially missed during traditional approach

I think I've corrected all the missed bugs between V1 and V2 of the traditional approach, but it's possible I've 
missed 1 or 2.

I'm not too concerned over this, as I feel like leaving them as potentially 'missed bugs' is useful to __highlight one 
of the pitfalls of traditional test automation__. 

It's easy to miss something, and often things are intentionally left out of a test suite, because of the amount of time
it would take to hook up matchers/assertions for each single element of a page.  Then some of the bugs require you
to check every css property, which is not an efficient use of time.