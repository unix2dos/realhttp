#!/bin/sh


rm -rf public
mkdir public
rm -rf .git/worktrees/public/
git worktree add -B gh-pages public origin/gh-pages
rm -rf public/*
echo "Generating site"
hugo -D


echo "www.realhttp.com" > public/CNAME


echo "Updating gh-pages branch"
msg="rebuilding site `date`"
if [ $# -eq 1 ]
	  then msg="$1"
fi
cd public && git add --all && git commit -m "$msg"


echo "Push to origin gh-pages"
git pull origin gh-pages
git push origin gh-pages
cd .. && rm -rf public

