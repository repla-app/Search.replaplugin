.PHONY: ci ac autocorrect lint

ci: lint
ac: autocorrect

lint:
	rubocop

autocorrect:
	rubocop -a

test:
	./Contents/Resources/test/run_tests.sh
