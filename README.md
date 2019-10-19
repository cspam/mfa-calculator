# README

You'll want Ruby 2.6.5 and Rails 6.0.0.

Clone this app, `cd` into the directory.

You may need to run `gem install bundler` first, and then `bundle install` should install all the libraries being used.

Once that's done, `rake db:create db:migrate`.

From there, you should be able to `rails s` and then visit `localhost:3000`.

The logic will be happening mostly in `app/services/calculation_service.rb`.

You can also play around in the console by just typing `rails c`.  For example, you could do `rails c`, and then try `cs = CalculationService.new(60000, 12000, 0, 1)` and then play around with the `cs` variable.