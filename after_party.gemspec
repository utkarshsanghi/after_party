Gem::Specification.new do |gem|
  gem.name = 'after_party'
  gem.version = '1.11.2'
  gem.date = '2019-03-25'

  gem.authors = 'Steve Mitchell'
  gem.description = 'Automated post-deploy tasks for Ruby/Rails. Your deployment is the party. This is the after party'
  gem.summary = 'A rails engine that manages deploy tasks and versions using activeRecord or mongoid'
  gem.homepage = 'http://github.com/theSteveMitchell/after_party'
  gem.email = 'thestevemitchell@gmail.com'
  gem.license = 'MIT'

  gem.files = Dir['lib/**/**']
  gem.require_path = 'lib'

  gem.required_ruby_version = '>= 2.3'

  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'factory_bot'
  gem.add_development_dependency 'generator_spec'
  gem.add_development_dependency 'mongoid'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-rails', '~> 3.4'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'sqlite3', '~> 1.3.6'
end