//
//  UIImageViewTestVC.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/18.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 UIViewContentModeScaleToFill铺满全显示可能变形,  会拉伸图片比例适应ImageView的frame， 图片可能会变形，但图片会全部显示在ImageView的里面，默认模式
 UIViewContentModeScaleAspectFit可能未铺满全显示不变形 等比例的缩放，图片会全部显示在ImageView的里面，会导致ImageView可能没有显示满
 UIViewContentModeScaleAspectFill铺满不变形可能显示不全, 按照原图片本身的尺寸显示在ImageView的中心，ImageView会显示满，可能只有部分图片显示在ImageView 的frame里面
   
 参考文献：1.UIViewContentMode详解；2.UIViewContentMode各类型的效果
 */
@interface UIImageViewTestVC : UIViewController

@end

NS_ASSUME_NONNULL_END
