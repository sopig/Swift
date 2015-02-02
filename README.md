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
####swift和OC中nil的区别
`Attention :`
  
	Swift的nil和OC的nil并不一样。在OC中，nil是一个指向不存在对象的指针。  
	在Swift中，nil不是指针，nil是一个确定的值，用来表示值缺失。任何类型的  
	可选都可以被设置为nil，不只是对象类型。`

`基本运算符：`
	
	求余运算符：a%b ，
	不同于OC和C，在swift中是可以对浮点数进行求余运算的，
	还有自增++和自减--运算可以是整形也可以是浮点型，
	
	所有标准C的比较运算符都是在Swift中使用。  
	在swift中也提供了恒等=== 和不恒等 !== 这两个比较符来判断两个对象是否引用同一个对象实例，
	这一点可以具体查看swift的类与结构
	`

`区间运算符`
	
	闭区间运算符
	a...b 表示定义一个包含从a到b的（包括a和b）的所有值的区间
	
	半闭区间运算符
	a..b表示定义一个包含a但不包含b的区间
`

`字符串和字符`
	String和Character
	String对象有一个isEmpty属性来判断该字符串是否为空
	String类型为值类型，所以当其进行常量、变量赋值操作或在函数/方法中传递时会进行值拷贝。  
	在不同情况下，都会对已有字符串值创建新的副本，并对该副本进行传递和赋值


	在OC中，NSString类型则不同，当您在Cocoa中创建了一个NSString类型实例，并将其传递给一个函数/方法时，
	或者赋给一个变量，您永远是传递或赋值同一个NSString实例的一个引用。除非你特别要求进行值拷贝，
	否则字符串不会进行赋值新副本操作	
	
	swift默认字符串拷贝的方式保证了在函数/方法中传递的是字符串的值，其明确您独有该字符串的值，无论这个字符串的值来自哪里，
	这样，你可以放心你传递的字符串本身不会被更改，除非是你自己更改它（不用担心因为值复制影响性能，swift编译器会优化字符串的使用，
	使实际的复制只发生在绝对必要的情况下，这意味着你可以讲字符串作为值类型的同时获得极高的性能）
`



####swift精选TIPS
[在Swift中应用Grand Central Dispatch(上)](http://www.cocoachina.com/swift/20150129/11057.html?utm_source=tuicool)  
[在Swift中应用Grand Central Dispatch(下)](http://www.cocoachina.com/swift/20150130/11054.html)  



[Swift 十二讲 前言和第一章(draft)](http://www.jianshu.com/p/f875bcb7e86c?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift 十二讲 第二章 常量变量类型元组字符串和操作符](http://www.jianshu.com/p/b4a202d6c77b?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift十二讲 第三章 数组字典函数和闭包](http://www.jianshu.com/p/94212e7f4030?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)
