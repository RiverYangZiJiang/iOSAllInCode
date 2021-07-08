//
//  YZJModel.h
//  AllInCode
//
//  Created by hd on 2021/6/30.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YZJModel : NSObject
/// <#注释#>
@property (nonatomic, copy) NSString *name;

/// <#注释#>
@property (nonatomic, assign) NSInteger age;

///
@property (nonatomic, strong) UIImage *image;

#pragma mark - YYCache方法
- (void)cacheModel;

+ (YZJModel *)getCacheModel;
@end

NS_ASSUME_NONNULL_END
