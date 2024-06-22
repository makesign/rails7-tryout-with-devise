.RECIPEPREFIX = -

run: open
- bin/rails server
open:
- open http://localhost:3000

ruby_version=$(shell cat .ruby-version)
ruby_gemset=$(shell cat .ruby-gemset)
rvm-info:
- @echo "rvm should use gemset specified in .ruby-version and .ruby-gemset after cd in dir, if not run:"
- @echo
- @echo "rvm gemset use ${ruby_version}@${ruby_gemset}"
- @echo
- rvm gemset list