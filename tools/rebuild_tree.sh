#!/bin/sh
# Seems that sometimes our tree gets out of whack and needs to be rebuilt. 
# This is a long and painful process that probably requires taking down the
# site for several hours.  You may also want to comment out some callbacks in
# app/models/taxon.rb to help this run a bit quicker, except the after_moves.


# Yes, twice.  This does a lot of merging, not 100% convinced it gets
# everything the 1st time
ruby script/runner "ThinkingSphinx.deltas_enabled = false; Taxon.find_duplicates"
ruby script/runner "ThinkingSphinx.deltas_enabled = false; Taxon.find_duplicates"

ruby script/runner 'ThinkingSphinx.deltas_enabled = false; Taxon.rebuild_without_callbacks'
ruby script/runner 'ListedTaxon.update_all_taxon_attributes'

rake ts:in
