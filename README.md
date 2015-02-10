The story of my swift adventure
==========

第一部分 Markdown
-----------------

####Markdown标记语法 

1. Markdown语法非常简单易读易写，建议以后写txt文档时候采用Markdown，这里是[Markdown](http://wowubuntu.com/markdown/)详细说明;  

2. MAC上非常好用的Markdown编辑器叫做Mou，这里[Mou](http://25.io/mou/)官方地址，有详细的文档和说明。

3. Markdown详细语法说明 [Markdown](https://github.com/ddapps/Swift/blob/master/Markdown%E8%AF%AD%E6%B3%95%E6%80%BB%E7%BB%93.md)

第二部分 Swift开源项目及使用注意点
----------------
####swift开源项目总结，持续更新
* 这里是保持持续更新的开源框架总结[Swift开源项目总结](https://github.com/ddapps/Swift/blob/master/swift%E5%BC%80%E6%BA%90%E9%A1%B9%E7%9B%AE%E6%80%BB%E7%BB%93.md)   

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
	可选都可以被设置为nil，不只是对象类型。

`基本运算符：`
	
	求余运算符：a%b ，
	不同于OC和C，在swift中是可以对浮点数进行求余运算的，
	还有自增++和自减--运算可以是整形也可以是浮点型，
	
	所有标准C的比较运算符都是在Swift中使用。  
	在swift中也提供了恒等=== 和不恒等 !== 这两个比较符来判断两个对象是否引用同一个对象实例，
	这一点可以具体查看swift的类与结构
	
`区间运算符`
	
	闭区间运算符
	a...b 表示定义一个包含从a到b的（包括a和b）的所有值的区间
	
	半闭区间运算符
	a..b表示定义一个包含a但不包含b的区间

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

	字符串可变性，注意在OC和Cocoa中，您通过选择两个不同的类（NSString和NSMutableString)来指定该字符串是否可以被修改   
	swift中德字符串是否可以被修改仅通过定义的是变量还是常量来决定  
	
	`计算字符数量---通过调用全局countElement函数，并将字符串作为参数进行传递可以获取该字符串的字符数量`  
	
	比较字符串，如果两个字符串以同一顺序包含完全相同的字符，则认为两者字符串相等   
	hasPrefix/hasSuffix方法来检查字符串是否拥有特定的前缀、后缀  
	你还可以通过字符串的uppercaseString和lowercaseString属性来访问一个字符串的大写小写版本  
	
`数组构造语句`

	[1,2,3];   
	var shoplist:Array<Int> = [1,2,3,4];   
	


`访问和修改数组`

	我们可以通过数组的方法和属性来访问和修改数组，或者下标语法。还可以使用数组的只读属性count来获取数组中德数据项数量  
	使用布尔项isEmpty来作为检查count属性的值是否为0的捷径  
	也可以使用append方法在数组后面添加新的数据项  
	除此之外，使用加法赋值运算符（+=）也可以直接在数组后面添加数据项  
	我们也可以使用假发赋值运算符（+=）直接添加拥有相同类型数据的数组  
	我们也可以利用下标[4...6]一次改变一系列数据项的值，即使新数据和原有数据的数量是不一样的  
	调用数组的insert(atIndex:)方法来在某个具体的索引值之前添加数据项  

`数组的遍历`

	for-in  
	利用全局函数enumerate函数来进行数组遍历。 enumerate返回一个由每一个数据项索引值和数据值组成的键值对组，  
	我们可以把这个键值对组分解成临时常量或者变量来进行遍历：  
	for(index,value) in enumerate(shoplist){  
	println("Item \(index + 1) :\(value)");   
	}  

`创建并且构造一个数组`

	我们可以使用构造语法来创建一个由特地部分数据类型构成的空数组：  
	var someInts = Int[]()  
	var threeDoubles = Double[](count:3,repeatedValue:0.0)传入数组构造函数  
	var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)  
	最后我们可以使用操作符(+)来组合两种已存在的相同类型数组。新数组的数据类型会从两个数组的数据类型中推断出来  

`字典`  
	
	swift自定使用Dictionary<KeyType,ValueType>定义，其中KeyType是字典中键得得数据类型，ValueType则是字典中值的  
	数据类型  

`读取和修改字典`  
	
	作为另一种下表方法，字典的updateValue（forKey:）方法可以设置或者更新特定键对应的值。  
	updateValue(forKey:)函数会返回包含一个字典值类型的可选值。举例来说：对于存储String值得字典，  
	这个函数会返回一个String?或者“可选 String”类型的值。 如果值存在，则这个可选值值等于被替换的值。  
	否则将会是nil   

`字典遍历`  
	  
	for-in ，每一个字典中得数据项都由（key，value）元组形式返回，并且我们可以使用暂时性的常量或者变量来分解这些元组。  
	
`创建一个空字典`  

	var nameOfIntegers = Dictionary<Int,String>();  
	还有一种方式是 var nameOfIntegers = [:] ;    

`集合的可变性`  

	注意：在我们不需要改变数组大小的时候创建不可变数组是很好的习惯。如此，编译器可以优化我们创建的集合
	
`函数`  

	* 多重返回值函数：可以将所有数据组织好，然后一元组的方式返回。  
	* 函数的外部参数名：  
	func join(string s1: String, toString s2: String, withJoiner joiner: String) -> String {
    return s1 + joiner + s2  
	}  
	* 也可以采用#简写外部参数名：  
	func containsCharacter(#string: String, characterToFind: Character) -> Bool {
        return false
	}  
	* 可变参数  
	func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
	}
	* 输入输出参数  
	定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。  
	func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
	}
	* 函数类型作为参数类型  
	* 函数类型作为返回类型  
	* 嵌套函数  
	func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
	}
	var currentValue = -4
	let moveNearerToZero = chooseStepFunction(currentValue < 0)
		// moveNearerToZero now refers to the nested stepForward() function
	while currentValue != 0 {
    println("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
	}
	println("zero!")

* 指针,一个swift敞亮或者变量引用一个引用类型的实例与C语言中的指针类似，不同的是并不直接指向内存中的某个地址。  
* 类和结构体的选择，在你的代码中可以使用类和结构体来定义你的自定义数据类型。  
  `结构体`实例总是通过值传递，`类`总是通过引用传递。  
* 值类型和引用类型的区别。  
* 字典类型的赋值和拷贝行为 无论何时将一个字典实例付给一个常量或者变量，或者传递给一个函数或方法，这个字典即会在赋值或者调用发生时被拷贝。  
 如果字典实例中所存储的键和或者值是值类型（结构体或者枚举），当赋值或者调用发生时，他们都会被拷贝。相反如果键值是引用类型，被拷贝的将是引用，而不是被他们引用得类实例或函数。字典的键值拷贝行为与结构体所存储的属性和拷贝行为相同。    
* 数组的赋值和拷贝行为  在swift中，数组(Array)类型的赋值和拷贝行为要比字典(Dictionary)类型的复杂的多。   
 **当操作数组内容时，数组能提供接近C语言得性能，并且拷贝行为只在必要时才发生，**  
 如果将一个数组实例赋给一个变量或者常量，或者将其作为参数传递给函数或方法调用，在事件发生时数组的内容不会被拷贝。相反数组公用相同的元素序列。当你在一个数组内修改某一元素时，修改结果也在另一数组显示。  
对数组来说，拷贝行为仅仅当操作有可能修改数组长度时才会发生。这种行为包括 appending \ insearting \removing 或者使用范围下标（range subscript）去替换这一范围内的元素。  
只有当数组拷贝确要发生时，数组内容的行为规则与字典中键值的相同  
* 确保数组的唯一性  
在操作一个数组，或将其传递给函数以及方法调用之前是很有必要先确定这个数组是由一个唯一拷贝的。。通过在数组变量上调用`unshare`方法来确定数组引用的唯一性。（当数组赋给常量时无法调用unshare方法）  
* 强制复制数组   
我们通过调用数组的copy方法进行强制显性复制。这个方法对数组进行了浅拷贝，并且返回一个包含此拷贝的新数组。  
注意：如果你仅需要确保你对数组的引用是唯一引用，请调用unshare方法，而不是copy方法，unshare方法仅仅会在确有必要时才会创建数组拷贝。copy方法会在任何时候都创建一个新的拷贝，即使引用已经是唯一引用。
* **属性**  
属性分为计算属性和存储属性。  
计算属性可以用于类、结构体和枚举里，存储属性只能用于类和结构体  
  
存储属性  



####swift官方文档
 [The Swift Programming Language 中文版](http://numbbbbb.gitbooks.io/-the-swift-programming-language-/content/index.html)  

####swift精选TIPS
[在Swift中应用Grand Central Dispatch(上)](http://www.cocoachina.com/swift/20150129/11057.html?utm_source=tuicool)  
[在Swift中应用Grand Central Dispatch(下)](http://www.cocoachina.com/swift/20150130/11054.html)  


[Swift 十二讲 前言和第一章(draft)](http://www.jianshu.com/p/f875bcb7e86c?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift 十二讲 第二章 常量变量类型元组字符串和操作符](http://www.jianshu.com/p/b4a202d6c77b?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift十二讲 第三章 数组字典函数和闭包](http://www.jianshu.com/p/94212e7f4030?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
[Swift 十二讲 第四章 范围区间和跨步和常用全局函数 (draft)](http://www.jianshu.com/p/7d3fbecfab30)  
[Swift 十二讲 第五章 Ifelse/for/while/Switch loop](http://www.jianshu.com/p/0ba4760d55c8)  
[Swift 十二讲 第六章 类 (Class) (draft)](http://www.jianshu.com/p/31ae2fb8fc93)  
[Swift 十二讲 结构体和聚合体 ,访问控制](http://www.jianshu.com/p/187486247cb8)      

