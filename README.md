Everything in swift
==========
```
-   最近在完成SDWebImage的swift版本改写。
```


##swift初识

_配置相关_
> [Markdown详细说明](http://wowubuntu.com/markdown/)    
> [Markdown编辑器Mou](http://25.io/mou/)  
> [Markdown详细语法](https://github.com/ddapps/Swift/blob/master/Markdown%E8%AF%AD%E6%B3%95%E6%80%BB%E7%BB%93.md)  
> [Swift开源项目总结](https://github.com/ddapps/Swift/blob/master/swift%E5%BC%80%E6%BA%90%E9%A1%B9%E7%9B%AE%E6%80%BB%E7%BB%93.md)     
> [swift与OC混合编程——swift-mix-oc](./swift_OC_programMix.md)
> [swift_language](./swift_language_tips.md)
> [swift中的关键字](http://www.cnblogs.com/jacklandrin/p/3782831.html)  
> [The Swift Programming Language 中文版](http://numbbbbb.gitbooks.io/-the-swift-programming-language-/content/index.html)  
> [Carthage使用](http://www.isaced.com/post-265.html)  

_语言语法特性_  

> [在Swift中应用Grand Central Dispatch(上)](http://www.cocoachina.com/swift/20150129/11057.html?utm_source=tuicool)  
> [在Swift中应用Grand Central Dispatch(下)](http://www.cocoachina.com/swift/20150130/11054.html)  
> [Swift 十二讲 前言和第一章(draft)](http://www.jianshu.com/p/f875bcb7e86c?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
> [Swift 十二讲 第二章 常量变量类型元组字符串和操作符](http://www.jianshu.com/p/b4a202d6c77b?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
> [Swift十二讲 第三章 数组字典函数和闭包](http://www.jianshu.com/p/94212e7f4030?utm_campaign=maleskine&utm_content=note&utm_medium=pc_author_hots&utm_source=recommendation)  
> [Swift 十二讲 第四章 范围区间和跨步和常用全局函数 (draft)](http://www.jianshu.com/p/7d3fbecfab30)  
> [Swift 十二讲 第五章 Ifelse/for/while/Switch loop](http://www.jianshu.com/p/0ba4760d55c8)  
> [Swift 十二讲 第六章 类 (Class) (draft)](http://www.jianshu.com/p/31ae2fb8fc93)  
> [Swift 十二讲 第七章 结构体和聚合体 ,访问控制](http://www.jianshu.com/p/187486247cb8)   
> [Swift 十二讲 第八章 类型扩展(Extensions)和协议 (draft)](http://www.jianshu.com/p/247be9669a24)   
> [Swift 十二讲 第九讲 操作符重载和泛型](http://www.jianshu.com/p/e3dc516fd465)   
> [Swift 十二讲 第十讲 选项(Optionals)和内存管理ARC (draft)](http://www.jianshu.com/p/2b066dd939ed)  


##swift必备知识点
####知识点1   
--- **函数柯里化**  
```swift
// 柯里化函数定义格式  
func <#function name#>(<#parameters#>)(<#parameters#>)-> <#return type#>{
    <#statements#>
}

_info1-1_  
class Curry: NSObject {
    // uncurried
    func add(a: Int, b: Int, c: Int) -> Int{
        println("\(a) + \(b) + \(c)")
        return a + b + c
    }
    
    // 手动实现柯里化函数
    // 把上面的函数转换为柯里化函数，首先转成接收第一个参数a，并且返回接收余下第一个参数b的新函数（采用闭包）
    // 基础不牢固可能看不懂,需要拆解来看
    // (a: Int) : 参数
    // (b:Int) -> (c: Int) -> Int : 函数返回值（一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数)
    
    // 定义一个接收参数a,并且返回一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
    func add(a: Int) -> (b:Int) -> (c: Int) -> Int{
        
        // 返回一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
        return { (b:Int) -> (c: Int) -> Int in
            
            // 返回一个接收余下第一个参数c，并且有返回结果为Int类型的函数
            return { (c: Int) -> Int in
                
                // 这里为什么能使用参数a,b,c。
                // 利用闭包的值捕获特性，即使这些值作用域不在了，也可以捕获到他们的值。
                // 闭包会自动判断捕获的值是值拷贝还是值引用，如果修改了，就是值引用，否则值拷贝。
                
                // 注意只有在闭包中才可以，a,b,c都在闭包中。
                return a + b + c;
                
            }
            
        }
        
    }
    
    // curried
    func addCur(a: Int)(b: Int)(c: Int) -> Int{
        println("\(a) + \(b) + \(c)")
        return a + b + c
    }
}
```

_info1-2_  

```swift

  // 创建柯里化类的实例
        var curryInstance = Curry()
        
        /*** 调用手动实现的柯里化函数 **/
        var r: Int = curryInstance.add(10)(b: 20)(c: 30)
        // 可能很多人都是第一次看这样的调用，感觉有点不可思议。
        // 让我们回顾下OC创建对象 [[Person alloc] init]，这种写法应该都见过吧，就是一下发送了两个消息，alloc返回一个实例，再用实例调用init初始化,上面也是一样，一下调用多个函数，每次调用都会返回一个函数，然后再次调用这个返回的函数。
        
        /***** 柯里化函数分解调用 *****/
        // 让我来帮你们拆解下，更容易看懂
        // curryInstance.add(10): 调用一个接收参数a,并且返回一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
        // functionB: 一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
        var functionB = curryInstance.add(10)
        
        // functionB(b: 20):调用一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
        // functionC: 一个接收参数c,返回值为Int类型的函数
        var functionC = functionB(b: 20)
        
        // functionC(c: 30): 调用一个接收参数c,返回值为Int类型的函数
        // result: 函数的返回值
        var res: Int = functionC(c: 30);
        
        // 这里会有疑问?，为什么不是调用curryInstance.add(a: 10)，而是curryInstance.add(10),functionB(b: 20),functionC(c: 30),怎么就有b,c,这是因为func add(a: Int) -> (b:Int) -> (c: Int) -> Int这个方法中a是第一个参数，默认是没有外部参数名，只有余下的参数才有外部参数名,b,c都属于余下的参数。
        
        /***** 系统的柯里化函数调用 *****/
        var result: Int = curryInstance.addCur(10)(b: 20)(c: 30)
        
        /***** 系统的柯里化函数拆解调用 *****/
        // curryInstance.addCur(10) : 调用一个接收参数a,并且返回一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
        // 注意：Swift是强类型语言，这里没有报错，说明调用系统柯里化函数返回的类型和手动的functionB类型一致
        // functionB: 一个接收参数b的函数,并且这个函数又返回一个接收参数c,返回值为Int类型的函数
        functionB = curryInstance.addCur(10)
        
        // functionC: 一个接收参数c,返回值为Int类型的函数
        functionC = functionB(b: 20)
        
        // result: 函数的返回值
        res = functionC(c: 30)
        
        // 打印 60，60，60说明手动实现的柯里化函数，和系统的一样。
        println("\(r),\(res),\(result)")
        
        /************************************ 华丽的分割线 *********************************************/
        /*************************** 实例方法的另一种调用方式（柯里化）************************************/
        // 创建柯里化类的实例
        var curryingInstance = Currying()
        
        // 调用function方法
        Currying.function(curryingInstance)()
        
        // 拆解调用function方法
        // 1.获取function方法
        let function = Currying.function(curryingInstance)
        // 2.调用function方法
        function()
        
        // 步骤都是一样，首先获取实例方法，在调用实例方法，实例方法怎么调用，就不需要在教了。
```
        
_info1-3_  

```swift
class Currying: NSObject {
    // 方法类型: () -> Void
    func function(){
        
        println(__FUNCTION__)
    }
    // 方法类型: (Int) -> Void
    func functionParam(a: Int){
        println(__FUNCTION__)
    }
    // 方法类型: (Int, b: Int) -> Void
    func functionParam(a: Int, b: Int){
        println(__FUNCTION__)
    }
    
    // 方法类型: (Int) -> () -> Void
    func functionCur(a: Int)(){
        println(__FUNCTION__)
    }
}
```

_info1-4_  

```swift

// 组合接口  
// 为什么要定义接口，为了程序的扩展性，以后只需要在接口中添加对应的组合方法就好了。  
protocol CombineUI
{
    func combine(top: () -> ())(bottom: () -> ())()
}

class UI: NSObject,CombineUI {
    func combine(top: () -> ())(bottom: () -> ())() {
        // 搭建顶部
        top()
        
        // 搭建底部
        bottom()
    }
}
```

_info1-5 文字总结_  
  柯里化(Currying),是函数式编程概念。也就是说把接受多个参数的方法变换成接受第一个参数的方法，  
并且返回接受余下的参数并且返回结果的新方法。 swift中我们可以这样写出多个括号的方法：  
```swift
func addTwoNumbers(a:Int)(b:Int) ->Int {
	return a+ b
}
```  
  然后通过只传入第一个括号内的参数进行调用，这样将返回另一个方法：  
```swift
let addToEndValue = addTwoNumbers(4)   //addToEndValue是一个Int->Int  
let result = addToEndValue(b:6)  //result = 10  
```
  柯里化是一种量产相似方法的好办法，可以通过柯里化一个方法模板来避免写出很多重复代码，也方便了今后的维护。  
  举一个实际应用的例子，在swift中的selector只能使用字符串生成。这面临一个很严重的问题就是难以重构，并且无法在编译期间进行检查，这是十分危险的行为。但是target-action是Cocoa中非常重要得设计模式，无论如何我们都要安全使用的话，一种可能的解决方式就是利用方法的柯里化。  请看以下的解决思路  
  ```swift
  protocol TargetAction {
  	func performAction()
  } 
  
  struct TargetActionWrapper<T:AnyObject>:TargetAction {
  	weak var target:T?
  	let action:(T) -> () -> ()
  	
  	func performAction() -> () {
  		if let t = target {
  			action(t)()
  		}
  	}
  }
  
  enum ControlEvent {
  	case TouchUpInside
  	case ValueChanged
  	//...
  }
  
  
  class Control {
  	var actions = [ControlEvent:TargetAction]()
  	
  	func setTarget<T:AnyObject>(target:T,action:(T)->()->(),controlEvent:ControlEvent) {
  		actions[controlEvent] = TargetActionWrapper(target:target,action:action)
  	}
  	
  	func removeTargetForControlEvent(controlEvent:ControlEvent) {
  		actions[controlEvent] = nil
  	}
  	
  	func performActionForControlEvent(controlEvent:ControlEvent) {
  			actions[controlEvent]?.performAction()
  	}
  	
  }
  
  ```  
  
####知识点2  
--- **将protocol的方法声明为_mutating_**  
  swift的`protocol`不仅可以被`class`类型实现，也适用于`struct`和`enum`.因为这个原因，我们在写给别人用的接口时需要多考虑是否使用`mutating`来修饰方法，比如定义为`mutating func myMethod()`。Swift的mutating关键字修饰方法是为了能够在该方法中修改`struct`或者是`enum`的变量，所以如果没有在接口方法里来实现这个接口的话，别人如果用`struct`或者`enum`来实现这个`protocol`的画，就不能在方法里改变自己的变量了。  比如下面的代码。
  ```swift
  protocol Vehicle {
  	var numberOfWheels:Int {get}
  	var color:UIColor {get set}
  	
  	mutating func changeColor()
  }
  
  struct Mycar:Vehicle {
  	let numbersOfWheels = 4
  	var color = UIColor.blueColor()
  	
  	mutating func changeColor() {
  		color = UIColor.redColor()
  	}
  }
  
  ```

 如果把`protocol` 定义中`mutating`关键字去掉的话，Mycar就没法编译，保持现有代码不变的话，会报错说没有实现接口。  
 另外在使用`class`来实现带有`mutating`的方法接口时，具体的实现方法的前面是不需要加`mutating`修饰的，因为`class`可以随意更改自己的成员变量。所以说在接口里用`mutating`修饰方法，对于`class`的实现完全透明，可以当做不存在的。
 
####知识点3
--  **多元组Turple**  
多元组基本上都是动态语言支持的特性。  
比如交换输入，普通程序员亘古以来可能都是这么写的
```swift
func swapMe<T>(inout a:T,inout b:T) {
	let temp = a
	a = b 
	b = temp 
}
```
但是要使用多元组的话，我们可以是不是用额外的交换空间就完成交换 
```swift
	func swapMe<T>(inout a:T,inout b:T) {
		(a,b) = (b,a)
	}
```
另外一个特别常用的地方是错误处理。OC时代我们已经习惯了在需要错误处理的时候先做一个NSError的指针，然后将地址传到方法里面等待填充：

```swift 
	NSError *error = nil;
	BOOL success = [NSFileManager defaultManager] moveItemAtPath@"/path/to/target" toPath:@"/path/to/detination" error:&error];
	if (!success) {
		NSLog(@"%@",error);
	}
	
```

现在我们新写库的时候可以直接考虑返回一个带有NSError的多元组，而不是去填充地址了：

```swift
	func doSomethingMightCauseError() -> (Bool,NSError ?) {
		if success {
			return (true,nil)
		} else {
			return (false,NSError(domain:"someErrorDomain",code:1,userInfo:nil))
		}
	} 
```

####知识点4  
-- **@autoclosure 和 ??**  
``@autoclosure`` 可以说是Apple的一个非常神奇的创造，因为这更多地像是在 ‘hack’这门语言。简单得说，@autoclosure做的事情就是把一句表达式自动地封装成一个闭包closure。这样有时候在语法上看起来就会非常漂亮。  
比如我们有一个方法接受一个闭包，当闭包执行的结果为true的时候打印：

```swift
func logIfTrue(predicate:() ->Bool) {
if predicate() {
	println("True")
}
}
```
在调用的时候我们需要写这样的代码  
```swift
logIfTrue({return 2>1})
```
还可以更近一步，因为这个闭包是最后一个参数，所以可以使用尾随闭包(trailing closure)的方式把大括号拿出来，然后省略括号，变成 
```swift
	logIfTrue(2>1)
```
但是不管使用哪种方式，要么是书写起来十分麻烦，要么是表达上不太清晰，看起来都让人生气。于是@autoclosure登场了。我们可以改换方法参数，在参数名前面加上@autoclosure关键字：
```swift
	func logIfTrue(@autoclosure predicate:() -> Bool) {
		if predicate() {
			println("true")
		}
	}
```
这时候我们可以直接写
```swift
logIfTrue(2>1)
```
来进行调用了，swift将会把 2>1这个表达式自动转换为 ()-> Bool. 这样我们就得到了一个写法简单，表意清楚的式子。  

在swift中，有一个非常有用的操作符，可以用来快速地对nil进行条件判断，那就是 _**??**_。这个操作符可以判断输入并在当左侧的值是非nil的optional值时返回其value，当左侧是nil时返回右侧的值，比如：
```swift
var level:Int?
var startLevel = 1

var currentLevel = level ?? startLevel
```
在这个例子中我们没有设置过level，因此最后startLevel被赋值给了currentLevel。如果我们充满好奇心地点进 ??的定义，可以看到 ?? 有两种版本：

```swift
func ??<T>(optional:T?,@autoclosure defaultValue:()->T?) ->T?

func ??<T>(optional:T?,@autoclosure defaultValue:()->T) ->T
```
在这里我们的输入满足的是后者，虽然表面上看startLevel只是一个Int,但是其实在使用时他被自动封装成一个()->Int,有了这个提示，我们不妨来猜测一下??的实现吧:

```swift
func ??<T>(optional:T?,@autoclosure defaultValue:()->T?)->T {
	switch optional {
		case .Some(let value):
			return value
		case .None:
			return defaultValue() 
	}
}
```
可能你会有疑问，为什么这里要使用autoclosure，直接接受T作为参数并返回不行么？这正是autoclosure的一个最值得称赞的地方。如果我们直接使用T，那么就意味着在??操作符真正取值之前，我们就必须准备好一个默认值，这个默认值的准备和计算是会消耗性能的。但是如果optional不是nil的话，我们是完全不需要这个默认值，而会直接返回optional解包后的值。这样一来，默认值就是白白准备了，这样的开销是完全可以避免的，方法是将默认值的计算推迟到optional判定为nil之后。  

就这样，我们可以巧妙地绕过条件判断和强制转换，以很优雅的写法处理对optional及默认的取值了。**还有** @autoclosure并不支持带有输入参数的写法，也就是只有形如()->T的参数才能使用这个特性进行简化。另外因为调用者往往很容易忽视@autoclosure这个特性,所以在写接受@autoclosure的方法时还请特别小心，如果在容易产生歧义或者误解的时候，还是使用完整地闭包写法会比较好   

####知识点5
-- **Optional Chaining**  
使用Optional Chaining 可以让我们摆脱很多不必要的判断和取值，但是在使用的时候需要小心陷阱。  

因为Optional Chaining是随时都可能提前返回nil的，所以使用Optional Chaining所得到的东西其实都是optional的。比如下面一段代码：

```swift
	class Toy {
		let name :String
		init(name:String) {
			self.name = name
		}
	}
	
	class Pet {
		var toy:Toy?
	}
	
	class Child {
		var pet:Pet?
	}
```
在实际使用中，我们想要知道小明的宠物得玩具得名字得时候，可以通过下面得Optional Chaining拿到： 
```swift
let toyName = xiaoming.pet?.toy?.name
```
注意虽然我们最后访问的是name，并且在Toy的定义中name是被定义为一个确定的`String`而非`String？`的，但我们拿到的toyName其实还是一个String?的类型。这是由于子啊Optional Chaining中我们任意一个 ?. 的时候都可能遇到nil而提前返回，这个时候当然就只能拿到nil了。  
在实际使用中，我们大多数情况下可能更希望使用Optional Binding来直接取值这样的代码

```swift
if let toyName = xiaoming.pet?.toy?.name {
	
}
```
可能单独拿出来看会很清楚，但是只要稍微和其他特性结合一下，事情会变得复杂起来。来看看下面的例子：

```swift
	extension Toy {
		func play(){
		
		}
	}
```

我们为Toy定义了一个扩展，以及一个玩玩具的方法play()。还是拿小明举例，要是有玩具的话就玩之：

```swift
xiaoming.pet?.toy?.play()
```
除了小明也许我们还有小红小李小张等等。。这种时候我们就需要抽象出一个闭包来使用。传入一个Child对象，如果小朋友有宠物并且宠物有玩具的话就去玩。于是你很有可能写出这样的代码：  
_**错误代码**_
```swift
let playClosure = {(child:Child) -> () in child.pet?.toy?.play()}
```
你会发现这么表意清晰的代码居然无法编译！！  

问题在于对于play()的调用上。定义的时候我们没有写play()的返回，这表示这个方法返回void(或者写作一对小括号，他们是等价的)。但是正如上面所说，经过Optional Chainging以后我们得到的是一个Optional的结果。也就是说，我们最后得到的应该是这样一个closure：
```swift
 let playClosure = {(child:Child) ->()? in 
 child.pet?.toy?.play()
 }
```

这样调用的返回将是一个()?  (或者写成void？更清楚一点)，虽然看起来有一点奇怪，但这就是事实。使用的时候我们可以通过Optional Binding来判定方法是否调用成功：
```swift
if let result:() = playClosure(xiaoming) {
	
} else {
	
}
```

####知识点6
--**操作符**  

与Objective-C不同，swift支持重载操作符这样的特性，最常见的使用方式可能就是定义一些简便的计算了。比如我们需要一个表示二维向量的数据结构：

```swift
struct Vector2D {
	var x = 0.0 
	var y = 0.0
}
```
一个很简单的需求就是两个Vector2相加：

```swift
let v1 = Vector2D(x:2.0,y:3.0)
let v2 = Vector2D(x:1.0,y:4.0)
let v3 = Vector2D(x:v1.x +v2.x,y:v1.y+v2.x)
```
如果只做一次的话似乎还好，但是一般情况我们会进行很多这种操作。这样的话，我们可能更愿意定义一个Vector2D相加的操作，来让代码简化清晰。

对于两个向量相加，我们可以重载加号操作符：
```swift
func +(left:Vector2D,right:Vector2D) ->Vector2D {
	return Vector2D(x:left.x+right.x,y:left.y+right.y)
}
```
这样，上面得V3以及之后的所有表示两个向量相加的操作就全部可以用加号来表达了：

```swift
let v4 = v1+ v2
```
类似的我们还可以为Vector2D定义其他运算符。  

上面定义的加号减号都是已经存在于swift运算符中了，我们所做的知识变换他的参数进行重载。如果我们想要定义一个全新的运算符的话，要做的事情会多一件。比如点积运算就是一个在适量运算中很常用的运算符，它表示两个向量对应坐标的成绩的和。根据定义，以及参考重载运算符的方法，我们选取+*来表示这个运算得话，我们不难写出：

```swift
func +*(left:Vector2D,right:Vector2D) ->Double {
	return left.x*right.x +left.y * right.y
}
```
但是编译器会给我们一个错误：
**Operator implementation without matching operator declaration**  
这是因为我们没有对这个操作符进行声明。如果我们要新加操作符的话，需要先对其进行声明，告诉编译器这个符号其实是一个操作符。添加如下代码：

```swift
infix operator +* {
	associativity none
	precedence 160
}
```
infix  
  表示要定义得是一个中位操作符，即前后都是输入；其他得修饰符还包括 `prefix`和`postfix`，不再赘述  

associativity  
  定义了结合律，即如果多个同类操作符顺序出现的计算顺序。比如常见的加法减法都是left，就是说多个加法同时出现时按照从左往右的顺序计算（因为加法满足交换律，所以这个顺序无所谓，但是减法的话计算顺序就很重要了）。点乘的结果是一个Double,不再会和其他点乘结合使用，所以这里写成none  

precedence  
运算的优先级，越高的话越优先进行进行运算。Swift中乘法和除法的优先级是150，加法和减法是140，这里我们定义点积优先级160，就是说应该早于普通的乘除进行运算。有了这些之后，我们就可以很简单的进行向量得点积运算了：

```swift
let result = v1 +* v2
```
最后需要多提一点的是，Swift操作符是不能定义在局部域中的，因为至少会希望在能在全局范围使用你的操作符，否则操作符也失去了意义了。另外，来自不同module的操作符室友可能冲突的。这对于库开发者来说是需要特别注意的地方。如果库中的操作符冲突的话，使用者是无法像解决类型名冲突那样通过指定库名字来进行调用的。因此在重载或者在自定义操作符时，应当尽量将其作为其他某个方法的简便写法，而避免在其中实现大量逻辑或者提供独一无二的功能。这样即使出现了冲突，使用者也还可以用方法调用的方式调用你的库。运算符的命名也应当尽量明了，避免歧义和可能的误解。因为一个不被公认的操作符是存在冲突风险和理解难度的，所以我们不应该滥用这个特性。在使用重载或者自定义操作符时，请一定要再三思考权衡。

####知识点7
-- _**func的参数修饰**_  
在声明一个Swift的方法的时候，我们一般不去指定参数前面的修饰符，而是直接声明参数：
```swift
	func incrementor(variable:Int) -> Int {
		return variable + 1
	}
```
这个方法接受一个Int的输入，然后通过将这个输入加1，返回一个新的笔输入大1的Int，就是一个简单的+1器。  

很多同学在大学的C程序设计里可能学过像 ++ 这样的自增运算符，再加上做了不少关于 判断一个数被各种前置++ 和后置++折磨后的输出是什么的考试题，所以之后写代码是也会不自觉地喜欢带上这种风格，于是同样的功能可能会写出类似这样的方法。  

**这是错误代码**  
```swift
func incrementor(variable:Int) -> Int {
	return ++variable
}
```
残念。。编译错误。为什么在swift里这样都不行呢？答案是因为Swift其实是一门讨厌变化的语言。所有有可能的地方，都被默认为是不可变的，也就是用let声明的，这样不仅可以确保安全，也能在编译器的性能优化上更有作为。在方法的参数上也是如此，我们不写修饰符的画，默认情况下所有参数都是let的，上面的代码等效为：
```swift
func incrementor(let variable:Int) ->Int {
	return ++variable
}
```
let的参数，不能重新赋值这是理所当然的。要让这个方法正确编译，我们需要做的改动是将let改为var：
```swift
func incrementor(var variable:Int) ->Int {
	return ++variable 
}
```
  
##LISENCE
      
The MIT License (MIT)

Copyright (c) 2015 Tolly Alamo [爱董铎]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
