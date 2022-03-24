#!/bin/bash
source ~/.proxyrc
echo $http_proxy

ROOT_HOME="${HOME}/go/src/blog/"
DOMAIN_NAME="yeahqing.cn"

cd ${ROOT_HOME}

# pwd

if [ ! -d docs ]; then
    echo "error: docs not found!"
else
    rm -r docs
    echo "clean successfully"
fi

hugo --theme=meme --baseUrl="https://yeahqing.cn/"

CNAME_FILE_PATH="docs/CNAME"
touch ${CNAME_FILE_PATH}
echo ${DOMAIN_NAME} > ${CNAME_FILE_PATH}
# cat ${CNAME_FILE_PATH}

echo "generate CNAME done"
# git status

git add .

git status

sleep 1s

MSG="auto commit at "$(date "+%Y-%m-%d %H:%M:%S")
echo ${MSG}

if  [ ! "$1" ]; then
    git commit -m "${MSG}"
else
    git commit -m "$1"
fi

sleep 1s
git push origin hugo
