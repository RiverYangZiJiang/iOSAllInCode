//
//  UIScrollViewVC.h
//  AllInCode
//
//  Created by 杨子江 on 11/30/20.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 content即ScrollView的子视图，ScrollView是一个视图，里面默认有两个水平和垂直方向滚动条的子视图UIScrollViewScrollIndicator
 ScrollView用来负责滚动，contentView用来显示内容
 contentSize:The size of the content view.即子视图的大小(width, height)，可以大于ScrollView的size
 contentOffset：The point at which the origin of the content view is offset from the origin of the scroll view.子视图相对于scrollView的位置(x, y)
 contentInset：The custom distance that the content view is inset from the safe area or scroll view edges.内容视图从安全区域或滚动视图边缘【注意】插入的自定义距离【即在边沿扩展content的范围】。如self.scrollView.contentInset = UIEdgeInsetsMake(50, 80, 0, 0); // 为scrollView顶部增加50，为其左边增加80的滚动区域。该属性常被用于UITableView中以解决最后一行cell被底部控件遮住的问题。



 作者：中峰
 链接：https://www.jianshu.com/p/7e750e396ec9
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 
 */
@interface UIScrollViewVC : UIViewController

@end

NS_ASSUME_NONNULL_END
