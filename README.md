# 用cocoapod管理私有库
这里提供的是终端命令行,不做过多的解释.
## 第一步 创建样板工程
```
$ cd 你要放置的位置
$ pod lib create CPYPrivatePodsDemo
``` 
创建之后会问你几个问题
1.要使用的语言
2.是否需要样例工程
3.是否需要一个测试框架
4.是否需要基于 View 的测试
5.还有类的前缀
我们这里不对这些选项做深入的探讨,我们只需要一个Example demo代码,前缀是必须的,其他选no.
![GitHub set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/Unknown.jpeg)
完成后在当前目录会出现一个 CPYPrivatePodsDemo 目录，cd 到这个目录中，我们可以看到如下文件
![GitHub set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/1.jpeg)

## 第二步 把组件相关的类放到工程中
把组件相关的类放到 CPYPrivatePodsDemo/Classes 目录中，这是里之所以要放到这个目录下是因为 Example 工程是中生成 Podfile 文件中指定了这个目录是源文件地址，我们按照默认的走就好。这里我们创建了一个测试文件和一个头文件，导入了这个测试文件，共三个文件放到 Classes 文件夹，如下：
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/2.jpeg)
我们需要更新 Example 工程，在终端中 cd 到 Example 目录下并运行 pod update/install 命令
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/3.jpeg)
CocoaPods 会更新 pod，这里直接从之前的 Classes 文件夹中获取文件更新，完成后我们再看回 Xcode 是上目录树，添加的三个文件出现在了 Development Pods 下
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/4.jpeg)
此时我们可以在测试一下，在 ViewController 导入这个框架，看看能不能创建 CPYTestView
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/5.jpeg)
嗯。。。好像编译通过了，这样就完成一半了，剩下的就是把这个 pod 发布，放到一个大家都可以访问的地方。

## 第三步 发布组件到 Git 仓库中
上面完成后,我们就可以把创建出来的这个模板创建放到远程的Git仓库中,这里我们在Github 创建仓库中,然后把代码push到远程.
分别两种方法
1. 第一种是通过SSH上传到仓库
1.1 配置shh公钥 https://coding.net/help/doc/git/ssh-key.html#部署ssh公钥 (具体方法)
1.2 打开SSH文件夹的方法
```
$ open ~/.ssh 
```
找到shh文件夹下的id_rsa.push
1.3 密钥配置到仓库里
github仓库的话在setting里面有个添加shh
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/6.png)
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/7.png)
2. 第二种是不通过SSH直接用HTTPS上传
2种方法的上传命令行都是一样的
```
$ git addr .
$ git commit -s -m "first commit"
$ git remote add origin git@git.coding.net:yyx_/secondClass.git(HTTPS这里就换成https网址)
$ git push origin master
```
如果出现一下情况
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/8.tiff)
```
直接用
git pull --rebase origin master //其中的原理参考 http://jingyan.baidu.com/article/f3e34a12a25bc8f5ea65354a.html
```
打开README.md文件,把里面的冲突解决掉,(如果冲突都不会的,那你考虑一下是不是去团队开发一下啦)解决了冲突之后,必须回到Example进行update.
如果在上传不成功,则执行下一句话
```
git push -u origin master -f
```
到这里你基本上已经100%成功了,如果有不成功的童鞋不要急,按照他给的问题,一一去查询解决.(个人建议,cocoapods和ruby的版本冲突不会影响,如果你处理到最后还不行,再去考虑版本冲突问题)
Podfile 指定的版本号的话在 pod install 时会找指定的 tag，所以我们这里需要打一个 tag
```
git tag '0.1.0'
git push origin 0.1.0
#可以不用 (把所有的tag传上去) git push --tags #推送tag到远端仓库
```
这里的话很多文章说'0.1.0'里面要加上v,个人觉得无所谓.重点是我下面说的.
==========================
查询hubgit 的tag 如果tag中没有数据,master上有数据,那么暂时建议
重新再自己的本地创建一个文件夹,从master 上clone下一份代码.再上传tag就成功了.
估计是因为在配置文件存在两个tag库造成冲突.
到这里的话在你的github上的仓库应该在master上和tag上都有你上传的代码了.恭喜你已经成功1/3了
## 第四步 编辑 podspec 文件
接下来我们要编辑 podspec 文件，在样板工程的根目录下有一个 CPYPrivatePodsDemo.podspec 文件，用文本编辑器打开，需要 summary, homepage 和 source 字段，其中 source 字段是刚刚把源码上传到的 Git 仓库地址，需要用 HTTPS 链接，source_files 字段和默认的一样，不用修改，因为我们之前就是把源文件放到这个目录的
```
#
# Be sure to run `pod lib lint CPYPrivatePodsDemo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.newdo|s|
s.name = 'CPYPrivatePodsDemo'
s.version = '0.1.0'
s.summary = 'A private pod test demo'

# This description is used to generate tags and improve search results.
# * Think: What does it do? Why did you write it? What is the focus?
# * Try to keep it short, snappy and to the point.
# * Write the description between the DESC delimiters below.
# * Finally, don't worry about the indent, CocoaPods strips it!

s.description = <<-DESC
TODO: Add longdescription of the pod here.
DESC

s.homepage = 'https://coding.net/u/cielpy/p/CPYPrivatePodsDemo'
# s.screenshots = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license = { :type => 'MIT', :file =>'LICENSE'}
s.author = { 'Cielpy'=>'beijiu572@gmail.com'}
s.source = { :git => 'https://git.coding.net/cielpy/CPYPrivatePodsDemo.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'CPYPrivatePodsDemo/Classes/**/*'

# s.resource_bundles = {
# 'CPYPrivatePodsDemo' => ['CPYPrivatePodsDemo/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
```
最重要的是你的版本要跟tag一样,你的source 字段是刚刚把源码上传到的 Git 仓库地址.这是最重要的.其他的参数就可以参考网上的一些.不会影响我们管理私有库了.

## 第五步 本地测试 podspec 文件是否可用

用 pod 提供的工具检查 podspec 文件是否合法，命令如下：
```
pod lib lint CPYPrivatePodsDemo.podspec
```
如果结果显示如下，说明是合法的
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/9.jpeg)
一下是我遇到的问题.如有相同按以下处理
遇到
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/10.tiff)
```
echo 3.0 > .swift-version
```
然后在验证podspec
如继续弹出有问题
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/11.tiff)
则在后面加上 ——allow-warnings(允许出现警告) —verbose(显示error日志)
如
```
pod lib lint CPYPrivatePodsDemo.podspec  ——allow-warnings —verbose
```
遇到这里的时候如果日志又没有,又显示错误.有可能是网络问题.所以我们可以多验证几次.你就成功了(一般第二次就好了)如下图
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/12.tiff)
然后我们在另建一个工程，运行 pod init 初始化 Podfile，加入 pod 并指定 podspec 路径，这里指定本地的 podspec 文件的路径。
```
use_frameworks!
target 'PodTest'do
pod 'CPYPrivatePodsDemo',:podspec=>'/Users/xx/Downloads/CPYPrivatePodsDemo/CPYPrivatePodsDemo.podspec'
end
```
然后执行 pod install ，顺利的话就可以安装成功了。如图
![github set up](https://raw.githubusercontent.com/HelloWordab/cocospod-/master/13.jpeg)
这一步会出问题的话,一般是你在坡地了文件的配置出错.(恭喜你到这里已经在本地成功了)






