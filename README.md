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

第三部分 swift笔记，
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
[Swift 十二讲 前言和第一章(draft)](http://www.jianshu.com/p/f875bcb7e86c?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift 十二讲 第二章 常量变量类型元组字符串和操作符](http://www.jianshu.com/p/b4a202d6c77b?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift十二讲 第三章 数组字典函数和闭包](http://www.jianshu.com/p/94212e7f4030?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)
