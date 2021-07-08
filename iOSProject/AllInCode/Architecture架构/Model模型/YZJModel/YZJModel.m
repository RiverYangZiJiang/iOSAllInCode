//
//  YZJModel.m
//  AllInCode
//
//  Created by hd on 2021/6/30.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJModel.h"
#import <NSObject+YYModel.h>
#import <YYCache.h>
@interface YZJModel ()<NSCoding>

@end

@implementation YZJModel
#pragma mark - YYModel方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    return [self yy_modelInitWithCoder:coder];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self yy_modelEncodeWithCoder:coder];
}

- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

#pragma mark - YYCache方法
- (void)cacheModel {
    YYCache *cache = [YYCache cacheWithName:[YZJModel cacheName]];
    [cache setObject:self forKey:[YZJModel cacheKey]];
}

+ (YZJModel *)getCacheModel {
    YYCache *cache = [YYCache cacheWithName:[YZJModel cacheName]];
    return (YZJModel *)[cache objectForKey:[YZJModel cacheKey]];
}

+ (NSString *)cacheName {
    return [self className];
}

+ (NSString *)cacheKey {
    return [self className];
}

@end
