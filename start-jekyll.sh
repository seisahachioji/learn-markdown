#!/bin/sh
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
pushd "${script_dir}/src"
bundle exec jekyll serve --watch --force_polling
popd
