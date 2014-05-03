# Don't give me your garbage, Rails
def coffee_gemfile_entry ; end
def create_test_files ; end
def database_gemfile_entry ; end
def javascript_gemfile_entry ; end
def run_bundle ; end

# I'll bring my own, thanks
run "rm Gemfile"

file "Gemfile", <<-Gemfile
source 'https://rubygems.org'
ruby '2.0.0'

#{rails_gemfile_entry.map {|gem| "gem '#{gem.name}', '#{gem.version}'#{"\n# #{gem.comment}" if gem.comment}" }.join("\n") }

gem 'bcrypt'
gem 'slim-rails'
gem 'pg'

# Assets
gem 'bourbon'
gem 'sass-rails'
gem 'uglifier'

group :development do
  gem 'mailcatcher', require: false
end

group :development, :test do
  gem 'fabrication'
  gem 'faker'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'guard-spring'
  gem 'poltergeist', require: false
end
Gemfile

run "rm README.rdoc"
run "touch README.md"

run "rm -rf app/assets/stylesheets"
run "mkdir app/assets/fonts"
run "touch app/assets/fonts/.gitkeep"
run "cp -r #{File.dirname(__FILE__)}/src app/assets/stylesheets"

run "mv config/database.yml config/database.yml.sample"

run "rm .gitignore"
file ".gitignore", <<-Gitignore
.bundle
.DS_Store
*.swp
config/database.yml
log/*.log
public/assets
Procfile
tmp
Gitignore

file ".ruby-version", "2.0.0-p247"

run "rm -rf test/"
run "bundle install"
generate "rspec:install"

file "spec/support/capybara.rb", "require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist"

git :init
git add: "."
