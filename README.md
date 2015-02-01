The story of my swift adventure
==========

第一部分 Markdown
-----------------

####Markdown标记语法 

######1.Markdown语法非常简单易读易写，建议以后写txt文档时候采用Markdown，这里是[Markdown](http://wowubuntu.com/markdown/)详细说明;  

#####2.MAC上非常好用的Markdown编辑器叫做Mou，这里[Mou](http://25.io/mou/)官方地址，有详细的文档和说明。

#####3.Markdown详细语法说明 [Markdown](https://github.com/ddapps/Swift/blob/master/Markdown%E8%AF%AD%E6%B3%95%E6%80%BB%E7%BB%93.md)

第二部分 Swift开源项目及使用注意点
----------------
####swift开源项目总结，持续更新
swift开源项目包含  
1.存储类  
2.网络类  
3.图片类  
4.界面类  
5.框架类  


这里是保持持续更新的开源框架总结[Swift开源项目总结](https://github.com/ddapps/Swift/blob/master/swift%E5%BC%80%E6%BA%90%E9%A1%B9%E7%9B%AE%E6%80%BB%E7%BB%93.md)   

swift笔记之
-------------
####swift与OC混合编程 swift和OC相互桥接的设置
```
swift和oc混合编程
a project with swift&oc mixed

OC类里面调用 swift 类 
选中targets->build settings ->packing->Product Module Name
 中设置模块名，这个名称很重要 swift 的头文件就是根据这个来命名的。

比如，如果需要将 OC 类里面调用 swift 类，
则需要将 Product Module Name 和 Product Name 分别填入，
 整个工程的 swift 类都自动包含到 Product Module Name 的模块中 
比如 你将 Product Module Name: SwiftModule,则在 OC 类里面调用 swift 类时，
需要 import “swiftModule-swift.h”

swift 里面调用 OC 类 新建一个.h 文件，在.h 文件里 import “”各需要的 OC 类
 选中targets->build settings ->SwiftCompiler ->Objective-C bridging header
 将这个头文件名称填入即可。
```

swift笔记之一
-------
```
前言
Swift是苹果公司于2014年六月宣布的最新编程语言。主要开发者是Chris Lattner。这是苹果的软件开发系统多年来最重要的一个更新。在可以预见的将来，整个苹果的软件开发系统，都会往Swift倾斜和逐步迁移。所以任何一个对苹果软件系统有兴趣的人，都应该花时间学习Swift。

更重要的是，Swift是一个好语言! 它综合了许多现代编译和计算机语言的最新技术。吸收了很多其他语言的优点和长处。任何一个对现代编译技术和计算机语言有兴趣的人，也应该花时间看下Swift的基本内容和发展。

Swift包含很强大的类型推断，这样程序员很多情况下，可以像脚本那样写程序，而不需指定类型。但Swift是静态类型语言，这确保了程序的速度。Swift还包含简明实用closure,protocol,generics以及不少functional programming语言的特征等等。因为全面支持unicode, Swift是笔者所知的，第一种支持变量名用中文的现代语言。在Internet很多著名的blogger都认为Swift包括的特征太多，难以段时间内分析详尽。但是没有人否定Swift会给开发者带来极大便利，会从整体上促进app开发的效率。

众所周知，之前apple的软件系统语言是objective-C。现在很多人有个疑问，未来Swift和objective-C关系的发展趋势是什么？笔者个人认为，Swift和Objective-C的关系未来会像80年代的C和汇编的关系。很多底层内容仍然需要Objective-C，但用到Objective-C的地方会越来越少。考虑到Internet对知识传播的速度提升，这个过程会很快。所以Apple的app开发人员需要尽快学习Swift,尽早完成产品迁移。目前，Swift可以和Objective-C混合编写app，并且apple的API都是既有Objective-C封装，又有Swift封装。所以现在生产成功的纯的或者混合Swift app产品，已经非常方便。唯一缺憾是，相对于Objective-C来讲，Swift的开源代码，控件和学习资料还相对较少。这需要程序员群体集体的逐步积累。

最后，Swift是一种还在发展中的语言，未来可能会有一些变化。另外，据说Swift没有被用来开发过大型类库。所以只有经过开发者群体的集体实践，才能最终明确Swift的优劣点。考虑到这点，笔者不建议在Swift非常偏僻的语法部分花太多时间。本书只集中精力介绍作者认为最有用的，而且未来一定会有用的那部分Swift语法。这当然和个人品味有关，也希望读者留言提出建议。

第一章 试一下Swift＋最基本的文本要素
a. 机器和环境
假设你有一台苹果电脑，并且安装了Xcode 6.1以上以及OSX 10.9以上的版本。有四种方法可以快速尝试用一下swift:

打开Xcode,点击文件，选 New project，选Swift语言
 如果你没从事过IOS或者OSX编程，不推荐这种方式试用Swift。
 因为一个项目里的过多元素会分散精力。
打开Xcode,选New playground

 这是笔者最推荐的方式。你可以保存一个空的playground放在桌面，经常练习使用。
创建一个Swift脚本，在OS X的terminal端运行。
step 1:在一个文本文件里，输入以下两行
#!/usr/bin/swift
println("哈哈哈")
step 2:把文本文件保存为1.swift
step 3:用如下命令行把1.swift标记为可执行
chmod u+x hello.swift
step 4:用如下命令运行1.swift
./1.swift

使用OS X的Swift Read-Evaluate-Print-Loop (REPL)
在terminal运行如下命令：
xcrun swift
如果你此前从未打开过Xcode,它会报错。再次输入上次的命令，会弹出一个窗口让你输入用户名和密码。输入正确的用户名和密码后，即可用命令行方式使用Swift
[添加图片]

b. Playground 再强调和一些小实验
按照Chris Lattner, Playground(http://nondot.org/sabre/) 受到Bret Victor的想法(http://worrydream.com/#!/LearnableProgramming) 以及软件light table的影响。你一边写程序的同时，在另半边可以看到当前的结果。这样会对你的思考流程有帮助，所以对你的效率和代码质量都有相当的提升。这一想法的正确与否，可能是因人而异的，这就像有人写作喜欢开markdown编辑器的右边显示板，有人不喜欢一样。但笔者鼓励每个读者都试验一下。

    let 小狗 = 1
    let b = 10
    println(小狗+b)
如上述代码，变量名可以用中文(实际上所有的identifiers都可以用中文)。另外因为Swift有类型推断，你不需要指定类型。上段代码的输出是11。

extension Int
{func neg() -> Int
{return -self}
}
var a=1
println(a.neg())
Swift允许对类型进行扩展。甚至对内建的基本类型，例如整型Int,也可以。上面这段代码扩展了整型，给整型添加了一个成员函数neg。这个函数返回这个整数的负。上面这段代码的输出是-1。

import UIKit

var uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
 uiButton.frame  = CGRectMake(0, 0, 100, 100)
 uiButton.backgroundColor = UIColor.yellowColor()
 uiButton.setTitle("黄按钮", forState: UIControlState.Normal);
在Playground输入以上代码，点开显示栏的timeline,你会在显示区看到一个黄按钮。这个例子充分显示了Playground的设计理念。就是你在写代码的同时，显示区显示出来代码会带来的效果。读者可以再试一下下面的例子：

let sineArraySize = 200

let frequency1 = 4.0
let phase1 = 0.0
let amplitude1 = 12.0
let sineWave = (0..<sineArraySize).map {
    amplitude1 * sin(2.0 * M_PI / Double(sineArraySize) *    Double($0) * frequency1 + phase1)
}
相信通过上面几个例子，读者已经可以初步体会Swift的强大简介，以及Playground的一些优点。笔者认为，如果有开源社区的充分支持，Playground甚至会成为一个数值分析计算的强大工具。Swift写起来并不比Matlab难多少。但同时又兼具类型安全编译语言的优点。

c. 基本文本要素：空格，注释，分号，import
Swift的空格被用来分隔基本的代码原子符号，不然空格被忽略。
    let a = 1
和

let a 
=
1
是一样的效果。

Swift用//来注释一行。用一对/**/注释一块代码。
/ /中可以包括别的/**/对。

Swift中行末尾不要求写分号。但你也可以写来表示这是一行代码的末尾。这样一行文字中就可以包含多行代码。

Swift不用头文件和#include。它使用import命令来引入已经定义好的模块中的public部分。例如:

 import UIKit //引入全部模块
 import Foundation.NSDate //引入一个模块中的一部分
 import func Darwin.sqrt //引入一个模块的一个函数
类似于函数，一个模块中的类，结构，变量等等，也都可以单独引入。
OSX开发最常用的模块是Cocoa。IOS则是UIKit。
、、、

