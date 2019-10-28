# README

You'll want Ruby 2.6.5 and Rails 6.0.0.

Clone this app, `cd` into the directory.

You may need to run `gem install bundler` first, and then `bundle install` should install all the libraries being used.

Once that's done, `rake db:create db:migrate`.

From there, you should be able to `rails s` and then visit `localhost:3000`.

The logic will be happening mostly in `app/services/calculation_service.rb`.

You can also play around in the console by just typing `rails c`.  For example, you could do `rails c`, and then try `cs = CalculationService.new(60000, 12000, 0, 1)` and then play around with the `cs` variable.

Sources:
Average dental costs of $360/year: https://www.moneyunder30.com/is-dental-insurance-worth-it#targetText=How%20much%20does%20dental%20insurance,annual%20benefit%20or%20coverage%20limit.
Average premium + OOP costs: https://www.commonwealthfund.org/publications/issue-briefs/2019/may/how-much-us-households-employer-insurance-spend-premiums-out-of-pocket
Average vision insurance: https://www.nerdwallet.com/blog/health/vision-insurance/
Average hearing aid price: https://www.consumerreports.org/hearing-aids/ways-to-spend-less-on-a-hearing-aid/
Average prescription drug prices: https://www.healthsystemtracker.org/chart-collection/recent-forecasted-trends-prescription-drug-spending/#item-nominal-and-inflation-adjusted-increase-in-rx-spending_2017