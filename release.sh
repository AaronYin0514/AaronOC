echo "删除本地AaronOC库"

pod repo remove AaronOC

echo "本地AaronOC库——已删除"

echo "添加远程仓库到本地"

pod repo add AaronOC https://github.com/AaronYin0514/AaronOC.git

echo "添加远程仓库完成"

echo "发布新版本"

pod repo push AaronOC AaronOC.podspec --allow-warnings

echo "发布完成"

if [ -d "~/.cocoapods/repos/AaronOC/AaronOC/Classes/" ]; then
        echo "包含Class文件夹，正在删除"
        rm -rf ~/.cocoapods/repos/AaronOC/AaronOC/Classes
        echo "删除Class文件夹完成"
fi

if [ -d "~/.cocoapods/repos/AaronOC/AaronOC/Assets/" ]; then
        echo "包含Assets文件夹"
        rm -rf ~/.cocoapods/repos/AaronOC/AaronOC/Assets
        echo "删除Assets文件夹完成"
fi
