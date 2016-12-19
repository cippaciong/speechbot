#! /bin/sh
for file in test/*.rb
do
    bundle exec ruby $file
done

