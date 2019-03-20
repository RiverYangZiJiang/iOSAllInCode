#  宏Tech

[1] [宏定义的黑魔法 - 宏菜鸟起飞手册](https://onevcat.com/2014/01/black-magic-in-macro/)



# 常用宏

## 尺寸宏

```
// 宽和高基本都是用的
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// navigationBar 默认的高度
#define NAVIGATIONBAR_HEIGHT 64
// tabBar 默认的高度
#define UITABBAR_HEIGHT 49  
```

## 颜色宏

```
// RGB颜色转换（16进制->10进制）
#define UICOLOR_HEX(hexString) [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16))/255.0 green:((float)((hexString & 0xFF00) >> 8))/255.0 blue:((float)(hexString & 0xFF))/255.0 alpha:1.0]
// 带有RGBA的颜色设置
#define UICOLOR_RGB(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// 随机颜色
#define UICOLOR_RANDOM  [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]
```

## 真机还是模拟器

```
#if TARGET_OS_IPHONE  
//iPhone Device  
#endif  

#if TARGET_IPHONE_SIMULATOR  
//iPhone Simulator  
#endif
```

## 系统宏

```
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 大于 iOS 8 的系统
#define ABOVE_IOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)
// 直接判断机型
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
```

## 目录宏

```
// Directory 目录
#define PATH_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Cache 目录
#define PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 数据库 目录
#define PATH_DATABASE_CACHE [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]
```

## 区分不同版本的文字宽度处理

PS: MBProgressHUD 获取

```
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define MB_TEXTSIZE(text, font) [text length] > 0 ? [text \
        sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
    #define MB_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
        attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
    #define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif
```

## 某些场景的宏

例如 KVO 中的那个 KeyPath, 有时我们直接输入，并不好输入，而且容易输入错误，没有提示。
这样写后，直接有提示，而且方便。

```
#define PQ_KEY_PATH(objc,keyPath) @(((void)objc.keyPath,#keyPath))
PQ_KEY_PATH(self.tableView, contentOffset);
```

------

同时，我们要注意在 Swift 中已经没有宏啦，为什么会没有呢？不可否认的是宏定义很可能隐藏很多 bug，这对于开发其实并不是一件好事。所以我们在使用的时候必须注意，具体可以看看喵神的[宏定义的黑魔法 - 宏菜鸟起飞手册](https://link.jianshu.com/?t=https://onevcat.com/2014/01/black-magic-in-macro/)。

[1] [iOS 中常用的宏](https://www.jianshu.com/p/e648122a691e)

# 系统自带的宏

```
// 获取两者之间小的
#define MIN(A,B)    ((A) < (B) ? (A) : (B))
// 获取两者之间大的
#define MAX(A,B)    ((A) > (B) ? (A) : (B))
// 绝对值
#define ABS(A)  ((A) < 0 ? (-(A)) : (A))
//CGFLOAT_MAX 无穷大
//CGFLOAT_MIN 无穷接近0
#if defined(__LP64__) && __LP64__
# define CGFLOAT_TYPE double
# define CGFLOAT_IS_DOUBLE 1
# define CGFLOAT_MIN DBL_MIN
# define CGFLOAT_MAX DBL_MAX
#else
# define CGFLOAT_TYPE float
# define CGFLOAT_IS_DOUBLE 0
# define CGFLOAT_MIN FLT_MIN
# define CGFLOAT_MAX FLT_MAX
#endif
// 这三个倒是用的不多
#define NSIntegerMax    LONG_MAX
#define NSIntegerMin    LONG_MIN
#define NSUIntegerMax   ULONG_MAX
//  UIKIT_EXTERN     extern
#ifdef __cplusplus
#define UIKIT_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
#define UIKIT_EXTERN            extern __attribute__((visibility ("default")))
#endif
```

相对来说，这块自身提供其实可以是常用的。特别是`MIN`，`MAX`，`CGFLOAT_MIN`都是常常用到的。





