# test_environment
Recreating a bug to resolve a problem

# The problem
Whenever I use ./run, I get a stack level too deep. This stems from models/node.rb where has_one :agency is placed.

If I comment it out, this issue goes away.

This was never a problem in ActiveRecord/Model/Support 4.1.5, but showed up in ActiveRecord/Model/Support 5.0.2

~~To further make matters worse. This test environment shows the issue in BOTH 4.1.5 *AND* 5.0.2. Why does this work in my production code for 4.1.5? What could possibly make this work? If anyone knows what could make this behavior function, without changing this code specifically, please let me know.~~

After clearing out all my gems, and reinstalling versions 4.1.5 and 5.0.2 of the three gems, the old version works again - like my actual production code does. I'm not sure what caused the mishap along the way.

5.0.2 versions of the three gems, the problem still persists.

# Environment
Bundler 1.14.6

PostgreSQL 9.5.6

Ruby 2.3.3 (using rbenv)

# Database information
The schema dump does not create the database for you, nor does it set the owner.

The username/database are in init.rb lines 12/13 to configure.

pg_dump.sql to create the relevant schema for the database.

# Explanation of relationships:

Agency contains Clients, which contains Presences. this test example only has Agencies, as the clients and presences are not relevant in recreating the problem.

Each Agency has a Node as an ambiguous entity so we can make stuff not care what part of the hierarchy we're at. The node has a has_one reference back to all layers, but only 1 will be populated for each Node.
