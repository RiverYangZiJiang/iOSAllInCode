#  系统

从iOS8.0开始使用UIAlertController，代替UIAlertView和UIActionSheet

```
NS_CLASS_AVAILABLE_IOS(8_0) @interface UIAlertController : UIViewController
```

已废弃UIAlertView(从屏幕中间弹窗)、UIActionSheet(从底部弹出多个选项)

```
NS_CLASS_DEPRECATED_IOS(2_0, 9_0, "UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead")
NS_CLASS_DEPRECATED_IOS(2_0, 8_3, "UIActionSheet is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead")
```





# 自定义

需求：从窗口中间弹窗，带遮罩

实现：将自定义视图作为window的子视图，代码如下[1]：

```
[[UIApplication sharedApplication].keyWindow addSubview:self];
```

# 第三方

## QMUIAlertController

用于代替系统的UIAlertController的模态弹窗控件，使用方式与UIAlertController相近，但相比UIAlertController

 支持了更多的功能，包括：

1. 支持大量的 UI 样式调整，包括间距、字体、文字颜色、背景色、分隔线颜色等。
2. **支持显示自定义的 view**。
3. 按钮也支持样式的自定义。
4. **支持判断当前是否有任一弹窗正在显示**（在某些通过 scheme 从外部跳转过来的场景特别方便）。

## SLAlertView

# 参考

[1] [SLAlertView](https://github.com/WSongLin/SLAlertView)



