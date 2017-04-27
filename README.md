# The Problem
Whenever I use ./run, I get a stack level too deep. This stems from models/node.rb where has_one :agency is placed.

If I comment it out, this issue goes away.

Agency has a after_create callback to create a Node, and an around_save callback to ensure the name/is_deleted fields of agency get applied to node. This ends up going into an infinite circular reference with around_save updating the related node, calling node.save, and somehow the node.save is triggering another save on the agency entity.

This was never a problem in ActiveRecord/Model/Support 4.1.5, but showed up in ActiveRecord/Model/Support 5.0.2

~~To further make matters worse. This test environment shows the issue in BOTH 4.1.5 *AND* 5.0.2. Why does this work in my production code for 4.1.5? What could possibly make this work? If anyone knows what could make this behavior function, without changing this code specifically, please let me know.~~

After clearing out all my gems, and reinstalling versions 4.1.5 and 5.0.2 of the three gems, the old version works again - like my actual production code does. I'm not sure what caused the mishap along the way.

5.0.2 versions of the three gems, the problem still persists.

# Running
Once everything is set up with bundler/postgres/schema etc,

./run will launch the version of 5.0.2 for the gems.

OLD=true ./run  will launch for version 4.1.5 for the gems. (this may require an OLD=true bundle install before-hand)

NULLDB=true ./run will launch using a nulldb ActiveRecord Adapter. (requires NULLDB=true bundle install)

OLD=true and NULLDB=true can be combined to run the old version with nulldb, but doesn't really add any benefit.

# Environment
Bundler 1.14.6

PostgreSQL 9.5.6

Ruby 2.3.3 (using rbenv)

# Database Information
The schema dump does not create the database for you, nor does it set the owner.

The username/database are in init.rb lines 12/13 to configure.

pg_dump.sql to create the relevant schema for the database.

# Explanation of Relationships:

Agency contains Clients, which contains Presences. this test example only has Agencies, as the clients and presences are not relevant in recreating the problem.

Each Agency has a Node as an ambiguous entity so we can make stuff not care what part of the hierarchy we're at. The node has a has_one reference back to all layers, but only 1 will be populated for each Node.
