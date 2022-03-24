#!/bin/bash

ROOT_HOME="${HOME}/go/src/blog/"
DOMAIN_NAME="yeahqing.cn"

cd ${ROOT_HOME}

pwd

if [ ! -d docs ]; then
echo "目录不存在"
else
echo "目录存在"
rm -r docs
echo "删除成功"
fi

hugo --theme=meme --baseUrl="https://yeahqing.cn/"

CNAME_FILE_PATH="docs/CNAME"
touch ${CNAME_FILE_PATH}
echo ${DOMAIN_NAME} > ${CNAME_FILE_PATH}
cat ${CNAME_FILE_PATH}

# git status

# git add .

# git commit -m "auto"

# git push origin hugo

