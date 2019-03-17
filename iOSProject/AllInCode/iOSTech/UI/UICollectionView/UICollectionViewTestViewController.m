//
//  UICollectionViewTestViewController.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/2.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "UICollectionViewTestViewController.h"
#import "CustomCollectionViewCell.h"

@interface UICollectionViewTestViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/**
 流水布局
 */
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@property (strong, nonatomic) UICollectionView *collectionView;

/**
 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation UICollectionViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加到视图
    [self.view addSubview:self.collectionView];
    
    // 不需要手动调用reloadData方法
//    [self.collectionView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s, self.collectionView.bounds.size.height = %f", __func__, self.collectionView.bounds.size.height);
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MLCustomCollectionViewCellId forIndexPath:indexPath];
    cell.title = self.dataArray[indexPath.row];
    NSLog(@"cell.title = %@", cell.title);
    return cell;
}

/**
 点击单元格

 @param collectionView <#collectionView description#>
 @param indexPath <#indexPath description#>
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath.row = %ld", indexPath.row);
}

#pragma mark - Custom Accessors
/**
 初始化UICollectionView

 @return <#return value description#>
 */
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.layout];
        // 注册cell
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:MLCustomCollectionViewCellId];
        
        _collectionView.scrollsToTop = NO;
        // 开启分页
        _collectionView.pagingEnabled = YES;
        //不显示滚动条
        _collectionView.showsHorizontalScrollIndicator = NO;
        //弹簧效果设置
        _collectionView.bounces = NO;
        //设置代理
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UICollectionViewLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        NSUInteger rowNum = 4;
        float margin = 8;
        float width = (self.view.bounds.size.width - margin * 2) / rowNum;
        //设置cell的尺寸(宽度和高度)，必须要设置itemSize，否则The default size value is (50.0, 50.0)
        _layout.itemSize = CGSizeMake(width, 100);
        //设置竖直滚动放向(默认是竖直方向)
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 默认left为0，导致会顶左边、顶右边显示
        _layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        // 列间距会根据itemSize的宽度、边距进行计算
        // 设置cell与cell之间的行距
//        _layout.minimumLineSpacing = 50;
        // 设置cell与cell之间的列距，可以设置为0
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3", @"4", @"5", @"6"]];
    }
    return _dataArray;
}
@end
