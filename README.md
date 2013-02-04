## After_party

After_party is a quick and easy gem that helps you create and manage automated deploy tasks in your Rails application.
A "deploy task" is a task that needs to be run ONCE in each environment where your code is deployed.
They run last in your automated deploy process, so you don't have to run this type of task manually.
It's very similar to the built-in schema migrations in rails, but has some crucial benefits over schema migrations:

1. Deploy tasks run as a separate rake task from schema migrations, so you can run them AFTER all your migrations run.
2. They do not run automatically in development environments.  Unless you want them to.  So you can separate your schema concerns from data concerns.
3. They are not schema migrations, because logically, they aren't migrating the schema.
4. Tasks aren't strictly run_once like schema migrations are.  Tasks have a descriptive names like regular rake tasks.  If I need to run a task manually after it's already run, I can run it manually like a standard rake task.


## So...who cares?

Examples of situations where a deploy task is the best fit:

* I've added a data field to a database model, and I need to populate that field with some complex logic.  This involves iterating through model instances and updating values.  I can only do this reliably if my model matches the code (meaning that all migrations must run before my data update)
* I need to remove invalid data, import from an external source, remove invalid characters from a model's title, or otherwise do some data-related update that is in no way related to a schema migration.  Normally I would write rake tasks for these, and manually run them in each environment (after the code is deployed there).  We're too smart for that.
* I have a task that needs to run at least once in each environment, but I still want a rake task that I can call manually, if I ever need to.
* I want to keep my DB schema updates separated from my data updates, so I can easily reference data updates if I need to.
* I just deployed my code to production, and I don't want to be late for the after party!

You can do all of these things in seeds, migrations, manual rake tasks, etc.  But why make things harder on yourself?

## Installation

After_party is compatible with Rails 3.1 or above.  Add it to your Gemfile with:

```ruby
#Gemfile
gem 'after_party'  ##NOT YET PUBLISHED TO RUBYGEMS.ORG DUE TO THEIR SYSTEM OUTAGE
```

Run bundle to install the gem.

Run the generator to create the required files in your application

```console
rails generate after_party:install
```

Creating a deploy task is easily done with

```console
rails generate after_party:task "description_of_what_the_task_does"
```

This creates a new rake task for you:
```console
create lib/tasks/deployment/20130130215258_description_of_what_the_task_does.rake
```

You can then run the rake task by name, or by calling
```console
rake after_party:run
```

The above command with run ALL your deploy tasks in order, and record each one in your database as it runs (just like schema migrations).

Finally, You'll want to glue this all together.  Update the deploy.rb (or whatever deployment script you use) so the tasks run automatically.  E.g. do a capistrano task:

```ruby
 #config/deploy.rb
 namespace :deploy do

   task :after_party, :roles => :web, :only => { :primary => true }  do
     run "cd #{release_path} &&  RAILS_ENV=#{stage} #{rake} after_party:run"
   end
 end

after  'deploy:update_code', 'db:migrate', 'db:seed', 'deploy:after_party'
```

This will ensure your deploy tasks always run after your migrations, so they can safely load or interact with any models in your system.

## Upcoming features:

1. Support for Mongoid databases.  Currently ActiveRecord is required.
2. Support for singluar/plural naming convention in databases.  Currently plural is default.
3. Support for additional parameters in the TaskGenerator to facilitate some smart-generation of task body.
4. Check for presence of deploy.rb.














