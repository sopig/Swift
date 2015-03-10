swift与oc 混合编程时的设置
==========================
* swift和oc混合编程

* OC类里面调用 swift 类 
选中targets->build settings ->packing->Product Module Name
 中设置模块名，这个名称很重要 swift 的头文件就是根据这个来命名的。

比如，如果需要将 OC 类里面调用 swift 类，
则需要将 Product Module Name 和 Product Name 分别填入，
 整个工程的 swift 类都自动包含到 Product Module Name 的模块中 
比如 你将 Product Module Name: SwiftModule,则在 OC 类里面调用 swift 类时，
需要 import “swiftModule-swift.h”

* swift 里面调用 OC 类 新建一个.h 文件，在.h 文件里 import “”各需要的 OC 类
 选中targets->build settings ->SwiftCompiler ->Objective-C bridging header
 将这个头文件名称填入即可。
