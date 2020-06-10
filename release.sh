#!/bin/bash

checkTag() {
    check_tag_result=`git ls-remote origin refs/tags/$1`
    if [ ${#check_tag_result} -gt 0 ]
    then
        echo "包含标签：$check_tag_result"
        return 0
    else
        echo "不包含标签"
        return 1
    fi
}

pushRepo() {
    pod repo push AaronSpecs AaronOC.podspec  --sources=https://github.com/AaronYin0514/AaronSpecs.git --allow-warnings --verbose
}

addTagAndPush() {
    git tag $1
    git push origin $1
    if [ $? == 0 ]
    then
        echo "正在发布库..."
        pushRepo
    else
        echo "标签上传失败"
    fi
}

tag=`awk -F\' '/s.version.*=/ {print $2}' AaronOC.podspec`

echo "新版本号:$tag"

checkTag $tag

if [ $? == 0 ]
then
    echo "包含标签"
    pushRepo
else
    echo "不包含标签"
    addTagAndPush $tag
fi
