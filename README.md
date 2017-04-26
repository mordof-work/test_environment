# test_environment
Recreating a bug to resolve a problem

# The problem
Whenever I use ./run, I get a stack level too deep issue. This stems from models/node.rb where has_one :presence, has_one :client, has_one :agency is placed.

If I comment those three out, and remove the inverse in the belongs_to for each of the three models/agency.rb, models/client.rb, models/presence.rb, this issue goes away.

This was never a problem in Rails 4.2 (ActiveRecord/Model/Support 4.2.6), but showed up in ActiveRecord/Model/Support 5.0.2

# Environment
Bundler 1.14.6

PostgreSQL 9.5.6

Ruby 2.3.3 (using rbenv)

# Database information
The schema dump does not create the database for you, nor does it set the owner.

The username/database are in init.rb lines 12/13 to configure.

pg_dump.sql to create the relevant schema for the database.

# My Suspicions
First off, this structure started (agency/client/presence) way back in Rails 3. We upgraded to Rails 4.2, added in Node. At that point we discovered that  .presence is a thing that exists - but it didn't conflict with anything.

Now in Rails 5.0.2, this is causing a stack level too deep.  Could it be   .presence  is actually a part of this?
