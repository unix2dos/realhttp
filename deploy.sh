#!/bin/sh

#if [[ $(git status -s) ]]
#then
#	    echo "The working directory is dirty. Please commit any pending changes."
#		    exit 1;
#fi

echo "Deleting old publication"
rm -rf public
mkdir public
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo -D

echo "Updating gh-pages branch"
msg="rebuilding site `date`"
if [ $# -eq 1 ]
	  then msg="$1"
fi
cd public && git add --all && git commit -m "$msg"


echo "Push to origin gh-pages"
git pull origin gh-pages
git push origin gh-pages
rm -rf public
