Everything in swift
==========
```Swift 
    最近在完成SDWebImage的swift版本改写。
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
知识点1 -- **函数柯里化**  
```swift
// 柯里化函数定义格式  
func <#function name#>(<#parameters#>)(<#parameters#>)-> <#return type#>{
    <#statements#>
}
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


##LISENCE
      

