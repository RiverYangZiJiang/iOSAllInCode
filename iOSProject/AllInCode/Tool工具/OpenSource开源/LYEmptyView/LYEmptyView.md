 #6.延迟显示emptyView
如示例1图，框架自动根据DataSource计算是否显示emptyView，在空页面发起网络请求时，DataSource肯定为空，会自动显示emptyView，有的产品需求可能不希望这样，希望发起请求时暂时隐藏emptyView【只是控制第一次的显示和隐藏时间，之后都是自动控制】。 本框架提供了两个方法可实现此需求，两个方法都是scrollView的分类，调用非常方便

```
//1.先设置样式
self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
//2.关闭自动显隐（此步可封装进自定义类中，相关调用就可省去这步）
self.tableView.ly_emptyView.autoShowEmptyView = NO;
//3.网络请求时调用
[self.tableView ly_startLoading];
//4.刷新UI时调用（保证在刷新UI后调用）
[self.tableView ly_endLoading];
```



 #7.特殊需求，手动控制emptyView的显示隐藏【即完全由手动来控制显示和隐藏，而不是像6.延迟显示emptyView，延迟显示只是控制第一次的显示和隐藏时间，之后都是自动控制】
 在某些特殊界面下，有的tableView/collectionView有固定的一些死数据，其它的数据根据网络加载，这时根据以上的示例方法可能达不到这需求。

