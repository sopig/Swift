操作符重载
==========

1. 自定义操作符  

  <pre>
  <code> 
  postfix operator ** { }
  postfix func ** (value: CGFloat) -> CGFloat {
   return value * value
  } 
  </code>
  </pre>
