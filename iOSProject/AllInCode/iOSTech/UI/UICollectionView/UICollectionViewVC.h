//
//  UICollectionViewVC.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/2.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewVC : UIViewController

/**
 使用场景：多行多列基本都使用；列数可能无穷多单行多列
 不用场景：单列多行，用TableView更方便
 一般不用场景：列数有限的单行多列场景，使用ScrollView，如banner、可滑动的顶部标题
 iOS开发UICollectionViewFlowLayout进行布局使用简书 https://www.jianshu.com/p/a043cd90def9
 iOS流布局UICollectionView系列一——初识与简单使用UICollectionView https://my.oschina.net/u/2340880/blog/522613
 计算UICollectionView一行能有几个item(cell) https://www.jianshu.com/p/72ca46f46589
 */
@end

NS_ASSUME_NONNULL_END
