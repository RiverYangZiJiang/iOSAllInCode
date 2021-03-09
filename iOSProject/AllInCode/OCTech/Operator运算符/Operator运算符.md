#  三元运算符

三元条件表达式`?:`是C中唯一一个三目运算符，用来替代简单的`if-else`语句，同时也是可以**两元**使用的：

```
NSString *string = inputString ?: @"default"; 
NSString *string = inputString ? inputString : @"default"; // 等价
```

object = object ?: assignment这个就是三目，只不过是***\*三目的两元使用\****，等价于object = object ? object : assignment。

