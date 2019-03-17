#  **instancetype**与id区别

1.使用instancetype替换id作为返回值,因为使用instancetype在编译时会做类型检查,这样能尽早发现问题,如果某方法的返回值是instancetype, 那么将返回值赋值给一个其它的对象会报一个警告.

区别1:
 在ARC(Auto Reference Count)环境下:
 instancetype用来在编译期确定实例的类型,而使用id的话,编译器不检查类型, 运行时检查类型.
 在MRC(Manual Reference Count)环境下:
 instancetype和id一样,不做具体类型检查
 区别2:
 id可以作为方法的参数,但instancetype不可以
 instancetype只适用于初始化方法和便利构造器的返回值类型

[1] [为什么你需要使用instancetype而不是id](https://www.jianshu.com/p/d2e2e1714b34) 

[2] [Why you should use instancetype instead of id](https://link.jianshu.com/?t=http%3A%2F%2Ftewha.net%2F2013%2F02%2Fwhy-you-should-use-instancetype-instead-of-id%2F)

[3] [stackoverflow](https://link.jianshu.com/?t=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F8972221%2Fwould-it-be-beneficial-to-begin-using-instancetype-instead-of-id)

[4] [Adopting Modern Objective-C](https://link.jianshu.com/?t=https%3A%2F%2Fdeveloper.apple.com%2Flibrary%2Fios%2Freleasenotes%2FObjectiveC%2FModernizationObjC%2FAdoptingModernObjective-C%2FAdoptingModernObjective-C.html%23%2F%2Fapple_ref%2Fdoc%2Fuid%2FTP40014150-CH1-SW11)

[5] [OC中instancetype与id的区别](https://www.jianshu.com/p/4443ed0a0520)

[6] [instancetype与id的区别](https://blog.csdn.net/baidu_28787811/article/details/80545552)



