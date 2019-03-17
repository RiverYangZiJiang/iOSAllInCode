//
//  UISearchControllerTestVC.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/12.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UISearchControllerTestVC.h"
#import "SearchResultsViewController.h"
#import <Masonry/Masonry.h>

@interface UISearchControllerTestVC ()
@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) SearchResultsViewController *searchResultsViewController;
@end

@implementation UISearchControllerTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 当在有navigation的时候点击搜索时，searchBar向上偏移64，哪怕作为titleView
//    self.navigationItem.titleView = self.searchController.searchBar;
//    self.definesPresentationContext = NO;
    
    [self.view addSubview:self.searchController.searchBar];
    [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(self.searchController.searchBar.bounds.size.height));
    }];
}

- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsViewController];
        _searchController.searchBar.showsCancelButton = YES;
//        _searchController.hidesNavigationBarDuringPresentation = YES;
    }
    return _searchController;
}

- (SearchResultsViewController *)searchResultsViewController{
    if (!_searchResultsViewController) {
        _searchResultsViewController = [[SearchResultsViewController alloc] init];
    }
    return _searchResultsViewController;
}

@end
