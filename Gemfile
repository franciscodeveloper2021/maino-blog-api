source "https://rubygems.org"

ruby "3.1.2"

# Core gems
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "bcrypt", "~> 3.1.7"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "i18n", "~> 1.8"
gem "rack-cors"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false

# Development and Test gems
group :development, :test do
  gem "debug", platforms: [:mri, :mswin, :mswin64, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 5.0.0"
  gem "byebug"
  gem "awesome_print"
end

# Test-only gems
group :test do
  gem "shoulda-matchers"
end

# Development-only gems
group :development do
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end
