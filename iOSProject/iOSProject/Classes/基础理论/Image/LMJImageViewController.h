//
//  LMJImageViewController.h
//  iOSProject
//
//  Created by yangzijiang on 2018/4/21.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 IMAGE-CAMERA-AUDIO-VIDEO-CALL控制器，继承自静态表格基类LMJStaticTableViewController
 
 排序：可以对已经选中的照片进行排序(微博、TZ、微信)
 裁剪：微博、TZ、微信
 原图：微博、TZ、微信
 */
@interface LMJImageViewController : LMJStaticTableViewController

#pragma mark - 图片选择、浏览
#pragma mark -- TZImagePickerController-图片、选择、预览、原图、简单的裁剪
/*
 https://github.com/banchichen/TZImagePickerController
 裁剪功能的正方形裁剪框不能动，只能拖动和缩放图片；裁剪和原图功能不能同时选择
 还可以选择视频
 */
 
#pragma mark -- CLImageEditor-滤镜、编辑、裁剪、旋转、模糊等
/**
 https://github.com/yackle/CLImageEditor
 powerful Image editor, you can crop裁剪、rotate旋转
 裁剪功能的正方形裁剪框可以动，但是不能拖动和缩放图片
 */

#pragma mark -- PEPhotoCropEditor-图片裁剪
/**
 https://github.com/kishikawakatsumi/PEPhotoCropEditor
 类似于iPhone自带的Photos里面的裁剪功能
 劣势：工程运行报错、长久不更新
 
 */

#pragma mark -- ZMJImageEditor-和微信一样图片编辑的组件
/**
 https://github.com/keshiim/ZMJImageEditor
 (ZMJImageEditor 是一个和微信一样图片编辑的组件，功能强大，极易集成，支持绘制、文字、旋转、剪裁、贴图等功能)
 优势：裁剪功能强大，裁剪功能的正方形裁剪框可以动，并且可以拖动和缩放图片
 */
#pragma mark - 图片压缩、缩放


@end
