//
//  MLCustomSegmentedControl.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/10.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLCustomSegmentedControl.h"
#import "MLCustomSegmentedControlItemView.h"

@interface MLCustomSegmentedControl ()<MLCustomSegmentedControlItemViewDelegate>
@property (strong, nonatomic) NSMutableArray<MLCustomSegmentedControlItemView *> *itemViews;
@end
@implementation MLCustomSegmentedControl
#pragma mark - MLCustomSegmentedControlItemViewDelegate
- (void)MLCustomSegmentedControlItemViewClicked:(MLCustomSegmentedControlItemView *)view{
    [self.itemViews enumerateObjectsUsingBlock:^(MLCustomSegmentedControlItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = (view.index == idx);
    }];
    
    if ([self.delegate respondsToSelector:@selector(MLCustomSegmentedControlItemViewClicked:)]) {
        [self.delegate MLCustomSegmentedControlItemViewClicked:view.index];
    }
}

#pragma mark - Custom Accessors
- (void)setTitles:(NSArray *)titles{
    NSLog(@"%s", __func__);
    _titles = titles;

    CGFloat width = self.bounds.size.width / titles.count;
    CGFloat height = self.bounds.size.height;
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MLCustomSegmentedControlItemView *itemView = [[MLCustomSegmentedControlItemView alloc] initWithTitle:obj index:idx isSelected:(idx == self.selectedIndex)];
        [self addSubview:itemView];
        itemView.frame = CGRectMake(idx * width, 0, width, height);
        itemView.delegate = self;
        
        [self.itemViews addObject:itemView];
    }];
}

- (NSMutableArray<MLCustomSegmentedControlItemView *> *)itemViews{
    if (!_itemViews) {
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
}
@end
