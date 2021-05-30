.PHONY: ci ac autocorrect lint gem_install

ci: gem_install lint
ac: autocorrect

lint:
	bundle exec rubocop

gem_install:
	bundle install --path vendor/bundle

autocorrect:
	bundle exec rubocop -a

test:
	./Contents/Resources/test/run_tests.sh

bundle_update:
	cd ./Contents/Resources/ &&\
		bundle update repla --full-index &&\
		bundle update &&\
		bundle clean &&\
		bundle install --standalone
