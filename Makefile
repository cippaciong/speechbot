TEST_FILES:= $(wildcard test/*_test.rb)

.DEFAULT_GOAL:=test

.PHONY: test
test: Gemfile.lock
	@bundle exec ruby -Ilib $(foreach file,$(TEST_FILES),$(file)) -e exit
