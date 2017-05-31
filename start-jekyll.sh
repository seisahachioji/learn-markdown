#!/bin/sh
pushd "/vagrant/src"
bundle exec jekyll serve --watch --force_polling
popd
