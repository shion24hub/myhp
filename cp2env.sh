#!/bin/bash

source ./.env

today=`date +%Y%m%d-%H%M%S`

if [ -d $REMOVE_DIR ]; then
    echo "Delete existing directories. It will be archived in the ARCHIVE_DIR."
    cp -r $REMOVE_DIR $ARCHIVE_DIR
    cd $ARCHIVE_DIR
    archived_dir_newname="archived-${DEV_ENV}-${today}"
    mv $DEV_ENV $archived_dir_newname
    cd $RETURN_PATH_FROM_ARCHIVE_DIR
    git_remove="${REMOVE_DIR}/../.git"
    rm -rf $git_remove
    rm -rf $REMOVE_DIR
else 
    echo "dir is not exist."
fi

cp -r $DEV_ENV $PRODUCTION_DIR
cd $PRODUCTION_DIR

heroku login

read -p "Is this your first deployment? (y/n): " ynf
case $ynf in 
    [yY]*)
        echo "ok"
        ;;
    [nN]*)
        read -p "Have you deleted the heroku app? (y/n): " ynd1
        case $ynd1 in
            [yY]*)
                echo "ok"
                ;;
            [nN]*)
                read -p "Delete an existing Heroku application. Are you sure? (y/n)" ynd2 
                case $ynd2 in
                    [yY]*)
                        echo "Delete an existing Heroku application."
                        heroku apps:destroy --app $APP_NAME --confirm $APP_NAME
                        echo "complete."
                        ;;
                    [nN]*)
                        exit 1
                        ;;
                esac
                ;;
        esac
        ;;
esac

echo "start creating heroku app"

heroku create $APP_NAME

repos_dir="https://git.heroku.com/${APP_NAME}.git"
commit_message="auto deploy ${today}"

git init
git remote add heroku $repos_dir
git add .
git commit -m "$commit_message"
git push heroku master

heroku open

cd $RETURN_PATH_FROM_PRODUCTION_DIR