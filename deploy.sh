#!/bin/bash
set -o errexit -o nounset
BASE_REPO=$PWD

commit_csvs() {
  Rscript -e 'source("R/rladies.R")'
 
  cd..; cd master
  git init

  git config --global user.name "benubah"
  git config --global user.email "ben@rpowerlabs.org"
  git config --global push.default simple
  git remote add upstream "https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git"
  git fetch upstream 2>err.txt


  cp -fvr $BASE_REPO/data/* .
  git add rladies.csv
  git commit -a -m "#rstats ${TRAVIS_COMMIT_MESSAGE} (${TRAVIS_BUILD_NUMBER})"
  git status
  git push 2>err.txt
  cd ..
}

commit_csvs
