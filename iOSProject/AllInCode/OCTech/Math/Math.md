#  最大值最小值

## 整形最大值、最小值

```
#define NSIntegerMax    LONG_MAX
#define NSIntegerMin    LONG_MIN
#define NSUIntegerMax   ULONG_MAX
```

## 浮点型最大值、最小值

```
//CGFLOAT_MAX 无穷大
//CGFLOAT_MIN 无穷接近0
# define CGFLOAT_TYPE double
# define CGFLOAT_IS_DOUBLE 1
# define CGFLOAT_MIN DBL_MIN
# define CGFLOAT_MAX DBL_MAX
```



# 函数

```
// 获取两者之间小的
#define MIN(A,B)    ((A) < (B) ? (A) : (B))
// 获取两者之间大的
#define MAX(A,B)    ((A) > (B) ? (A) : (B))
// 绝对值
#define ABS(A)  ((A) < 0 ? (-(A)) : (A))
```

