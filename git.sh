#! /bin/sh
basepath=$(cd `dirname $0`; pwd)
filename=${0##*/}
project=$1
branch=$2
if [[ ! -n "$project" ]];
then
  echo "usage of project name is 'api|mapi|backend-old|backend|crontab|supplier|h5|dispatchService'"
  exit
else
   if [[ ! -n "$branch" ]];
   then
     echo "usage of branch name is 'uat|master'"
     exit
   fi
   if [[ $project = 'dispatchService' ]];
   then
        cd /data/www/dispatchService
   else
        cd /data/www/zhx-$project
   fi
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
