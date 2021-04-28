#  系统

从iOS8.0开始使用UIAlertController，代替UIAlertView和UIActionSheet，其继承自UIViewController，需要使用presentViewController弹出

```
NS_CLASS_AVAILABLE_IOS(8_0) @interface UIAlertController : UIViewController
```

已废弃UIAlertView(从屏幕中间弹窗)、UIActionSheet(从底部弹出多个选项)

```
NS_CLASS_DEPRECATED_IOS(2_0, 9_0, "UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead")
NS_CLASS_DEPRECATED_IOS(2_0, 8_3, "UIActionSheet is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead")
```





# 自定义

参考《自定义-复杂-UI.doc》

# 第三方

## QMUIAlertController

参考《自定义-复杂-UI.doc》

## SLAlertView

# 参考

[1] [SLAlertView](https://github.com/WSongLin/SLAlertView)



