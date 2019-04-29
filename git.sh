#! /bin/sh
basepath=$(cd `dirname $0`; pwd)
filename=${0##*/}
project=$1
branch=$2
path=/data/www
if [[ ! -n "$project" ]];
then
  echo "usage of project name is 'a|b|c'"
  exit
else
   if [[ ! -n "$branch" ]];
   then
     echo "usage of branch name is 'uat|master'"
     exit
   fi

   cd $path/$project

   git pull
   if [[ $branch = 'uat' ]];
   then
        git checkout $branch
        git pull
        git merge dev
        git push origin $branch
   else
        git checkout $branch
        git pull
        git merge uat
        git push origin $branch
   fi
   git checkout dev
fi
