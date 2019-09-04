//
//  ViewController.m
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import "ViewController.h"
#import "USNetworkService.h"
#import "USPhotoModel.h"
#import "USPhotoListCell.h"
#import "LargeImageDownsizingViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MJRefreshGifHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshAutoFooter *refreshFooter;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 通用设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    UIColor *tintColor = [UIColor colorWithHexString:@"0x474747"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:tintColor, NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    self.navigationController.navigationBar.tintColor = tintColor;
    
    [self layoutUI];
    [self loadNewData];
}

#pragma mark - private
/// 布局界面
- (void)layoutUI {
    self.title = @"推荐";
    
    self.tableview.mj_header = self.refreshHeader;
    self.tableview.mj_footer = self.refreshFooter;
    [self.tableview registerClass:[USPhotoListCell class] forCellReuseIdentifier:NSStringFromClass([USPhotoListCell class])];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)loadNewData {
    self.page = 1;
    [self getPhotosCuratedListDataNetWork];
}

- (void)loadMoreData {
    self.page += 1;
    [self getPhotosCuratedListDataNetWork];
    
}

- (void)handleRequestWithResponce:(id)resp andError:(NSError *)error {
    (_refreshHeader && _refreshHeader.isRefreshing) ? [self.refreshHeader endRefreshing] : nil;
    
    (_refreshFooter && _refreshFooter.isRefreshing) ? [self.refreshFooter endRefreshing] :nil;
}

- (void)getPhotosCuratedListDataNetWork {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(self.page);
    
    [USNetworkService getDataWithParameter:param  notReachableFromeCache:YES successBlock:^(id  _Nonnull responseObject) {
        [self handleRequestWithResponce:responseObject andError:nil];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:[USPhotoModel mj_objectWithKeyValues:dic]];
                }
            }
            
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:arr];
            
            [self.tableview reloadData];
        }else {
            [MBProgressHUD showMessage:@"请稍后再试" into:self.view];
        }
    } failureBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        [self handleRequestWithResponce:responseObject andError:nil];
        [MBProgressHUD showMessage:@"请稍后再试" into:self.view];
    }];
}

#pragma mark - UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    USPhotoListCell *cell = [self.tableview dequeueReusableCellWithIdentifier:NSStringFromClass([USPhotoListCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.dataArr.count) {
        cell.model = self.dataArr[indexPath.row];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsIntableview:(UITableView *)tableview {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArr.count) {
        USPhotoModel *model = self.dataArr[indexPath.row];
        return model.rowHeight;
    }
    return 0.f;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArr.count) {
        dispatch_main_async_safe(^{
            LargeImageDownsizingViewController *vc = [[LargeImageDownsizingViewController alloc] init];
            vc.view.backgroundColor = UIColor.whiteColor;
            USPhotoListCell *cell = [tableview cellForRowAtIndexPath:indexPath];
            if (cell) {
                vc.thumbImage = cell.photoView.image;
            }
            vc.model = self.dataArr[indexPath.row];
            
            [self presentViewController:vc animated:YES completion:nil];
        });
        
    }
}


- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.delaysContentTouches = NO;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
            _tableview.estimatedRowHeight = 0;
        }
    }
    
    return _tableview;
}
    
- (MJRefreshGifHeader *)refreshHeader{
    if (_refreshHeader == nil) {
        _refreshHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
    }
    return _refreshHeader;
}

- (MJRefreshAutoFooter *)refreshFooter{
    if (_refreshFooter == nil) {
        _refreshFooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _refreshFooter;
    
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
