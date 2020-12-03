//
//  MKMapViewTestVC.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/22.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MKMapViewTestVC.h"
#import <Masonry/Masonry.h>
#import "MLAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "MLAnnotationView.h"
#import "MLMacroColor.h"
#import "MLMarcoFont.h"

@interface MKMapViewTestVC ()<MKMapViewDelegate>
/**
 苹果系统自带地图视图
 */
@property (strong, nonatomic) MKMapView *mapView;

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locationM;

/** 地理编码 */
@property (nonatomic, strong) CLGeocoder *geoC;

/**
 跳转到用户位置视图，点击该视图，地图会移动到用户当前位置
 */
@property (strong, nonatomic) UIView *gotoUserLocationView;

/**
 用户当前位置
 */
@property (strong, nonatomic) MKUserLocation *userLocation;

@property (strong, nonatomic) UIView *stationInfoView;

@property (strong, nonatomic) UIView *stationInfoTableView;

@end

@implementation MKMapViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self computeDistanceOfStartPoint:CLLocationCoordinate2DMake(22.652734, 114.066915) endPoint:CLLocationCoordinate2DMake(22.653051, 114.06846)];
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.stationInfoView];
    [self.stationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@136);
    }];
    
    [self addOneAnnoationWithCoordinate:CLLocationCoordinate2DMake(22.628024, 114.050021) color:[UIColor redColor] total:11];
    [self addOneAnnoationWithCoordinate:CLLocationCoordinate2DMake(22.649254, 114.05663) color:[UIColor yellowColor] total:111];
//    [self addOneAnnoationWithCoordinate:CLLocationCoordinate2DMake(22.625024, 114.054021) color:[UIColor redColor] total:1];
//    [self addOneAnnoationWithCoordinate:CLLocationCoordinate2DMake(22.624024, 114.050021) color:[UIColor redColor] total:4];
//    [self addOneAnnoationWithCoordinate:CLLocationCoordinate2DMake(22.648254, 114.05763) color:[UIColor yellowColor] total:22];

    //添加手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.mapView addGestureRecognizer:longPress];
    
    [self.view addSubview:self.gotoUserLocationView];
    [self.gotoUserLocationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-12);
        make.width.height.equalTo(@36);
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserLocationViewClicked)];
    [self.gotoUserLocationView addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - Selectors
- (void)gotoUserLocationViewClicked{
    NSLog(@"%s", __func__);
    [self.mapView setCenterCoordinate:self.userLocation.location.coordinate animated:YES];
}

-(void)longPress:(UILongPressGestureRecognizer *)sender
{
    //获取当前位置
    CGPoint location = [sender locationInView:self.view];
    //转换经纬度
    CLLocationCoordinate2D coordinate =[self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    NSLog(@"%s, latitude = %f, longitude = %f", __func__, coordinate.latitude, coordinate.longitude);
    //创建标注
    MLAnnotation *annotation = [[MLAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"新的标注";
    annotation.subtitle = @"待开发。。";
    //添加标注
    [self.mapView addAnnotation:annotation];
    
}
/**
 *  在地图上操作大头针, 就等于操作大头针数据模型
 *  添加大头针: 添加大头针数据模型
 *  删除大头针: 删除大头针数据模型
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    return;
    NSLog(@"%s", __func__);
    // 要求, 鼠标点击地图的哪个位置, 就在对应的位置加一个大头针
    
    // 1. 获取当前用户在屏幕上点击的点坐标
    UITouch *touch = [touches anyObject];
    CGPoint center = [touch locationInView:self.mapView];
    
    // 2. 把点坐标 转换成 在地图对应的地理坐标
    CLLocationCoordinate2D centerCoordinate = [self.mapView convertPoint:center toCoordinateFromView:self.mapView];
    
    // 3. 设置弹框标题和子标题
    NSString *title = @"连线";
    NSString *subTitle = @"iOS技术部";
    
    // 4. 调用自定义方法, 添加大头针数据模型
    MLAnnotation *annotation = [self addAnnotationWithCoordinate:centerCoordinate title:title andSubtitle:subTitle];
    
    // 反地理编码
    CLLocation *location = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 地标对象
        CLPlacemark *pl = [placemarks firstObject];
        
        // 取详细地址
        NSString *name = pl.name;
        
        // 获取城市
        NSString *city = pl.locality;
        
        annotation.title = city;
        annotation.subtitle = name;
        
    }];
    
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    return;
    NSLog(@"%s", __func__);
    // 获取地图上所有的大头针数据模型
    NSArray *annotations = self.mapView.annotations;
    
    // 移除大头针
    [self.mapView removeAnnotations:annotations];
}

/**
 *  自定义方法,添加大头针
 *
 *  @param center   大头针扎在哪
 *  @param title    弹框标题
 *  @param subTitle 弹框子标题
 */
- (MLAnnotation *)addAnnotationWithCoordinate:(CLLocationCoordinate2D)center title:(NSString *)title andSubtitle:(NSString *)subTitle
{
    
    MLAnnotation *annotation = [[MLAnnotation alloc] init];
    annotation.coordinate = center;
    
    annotation.title = title;
    annotation.subtitle = subTitle;
    
    [self.mapView addAnnotation:annotation];
    return annotation;
    
}


- (void)addAnnotation
{
    // 添加大头针 == 添加大头针数据模型
    
    // 1. 创建大头针数据模型
    MLAnnotation *annotation = [[MLAnnotation alloc] init];
    // 1.1 设置经纬度
    annotation.coordinate = self.mapView.centerCoordinate;
    // 1.2 弹框标题
    annotation.title = @"连线";
    // 1.3 弹框子标题
    annotation.subtitle = @"iOS研发部";
    
    // 添加大头针数据模型
    [self.mapView addAnnotation:annotation];
}

#pragma mark - Private

- (void)addOneAnnoationWithCoordinate:(CLLocationCoordinate2D)coordinate color:(UIColor *)color total:(NSUInteger)total{
    static NSUInteger num = 0;
    //创建标注
    MLAnnotation *annoation = [MLAnnotation annotationWithCoordinate:coordinate color:color total:total];
    annoation.type = num++ % 2;
    NSLog(@"%s annoation.type = %lu", __func__, (unsigned long)annoation.type);
    
    annoation.title = @"CM工单111";
//    annoation.subtitle = @"好牛B的地方";
    //添加标注
    [self.mapView addAnnotation:annoation];
    
    //让地图显示标注的区域
//    [self.mapView setCenterCoordinate:annoation.coordinate animated:YES];
    
    // Center map
//    self.mapView.visibleMapRect = [self makeMapRectWithAnnotations:@[annoation]];
}

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
    
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    return flyTo;
}
#pragma mark -- 计算距离
- (void)computeDistanceOfStartPoint:(CLLocationCoordinate2D )startPoint endPoint:(CLLocationCoordinate2D )endPoint{
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:startPoint.latitude longitude:startPoint.longitude];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:endPoint.latitude longitude:endPoint.longitude];
    NSLog(@"距离 = %f meters", [endLocation distanceFromLocation:startLocation]);  // 距离 = 162.633244 meters
}

#pragma mark -MKMapViewDelegate
/**
 *  当地图获取到用户位置时调用
 *
 *  @param mapView      地图
 *  @param userLocation 大头针数据模型
 */
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.userLocation = userLocation;
    CLLocationCoordinate2D center = userLocation.location.coordinate;
//    return;
    NSLog(@"%s longitude = %f, latitude = %f", __func__, center.longitude, center.latitude);
    // MapKit框架的中级使用--区域显示
    /**
     *  MKUserLocation : 专业术语: 大头针模型 其实喊什么都行, 只不过这个类遵循了大头针数据模型必须遵循的一个协议 MKAnnotation
     // title : 标注的标题
     // subtitle : 标注的子标题
     */
    userLocation.title = @"CM工单111";
//    userLocation.subtitle = @"CM工单111";
    
    // 移动地图的中心,显示用户的当前位置
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    
    // 显示地图的显示区域
    if (center.longitude > 0) {  // 第一次调用本方法时，经纬度都为0
        static dispatch_once_t onceToken;  // 只在第一次得到经纬度时放大显示用户位置
        dispatch_once(&onceToken, ^{
            [self showRigion:userLocation.location.coordinate];
        });
    }
}

/**
 显示地图的显示区域，会放大地图到特定区域大小，以显示center

 @param center 控制区域中心
 */
- (void)showRigion:(CLLocationCoordinate2D)center{
    NSLog(@"%s", __func__);
    // 设置区域跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.077919, 0.044529);
    
    // 创建一个区域
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    // 设置地图显示区域，这样地图就能以特定尺寸显示当前位置
    [self.mapView setRegion:region animated:YES];
}

/**
 *  地图区域已经改变时调用 --- 先缩放 获取经纬度跨度，根据经纬度跨度显示区域
 *
 *  @param mapView  地图
 *  @param animated 动画
 */
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%s %f---%f", __func__, mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

/**
 *  地图区域将要改变时带哦用
 *
 *  @param mapView  地图
 *  @param animated 动画
 */
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"%s %f---%f", __func__, mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

/**
 *  系统的大头针视图返回如果为nil , 实现方案
 *
 *  @param mapView    地图
 *  @param annotation 大头针数据模型
 *
 *  @return 大头针视图
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSLog(@"%s", __func__);
    
    // 如果是系统的大头针数据模型, 那么使用系统默认的大头针视图,
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        // 无法修改系统图标，并且也没有必要修改，因为系统图标会显示方向
        MKAnnotationView *annotationView = [mapView viewForAnnotation:annotation];
        annotationView.image = [UIImage imageNamed:@"location"];
        return annotationView;
    }
    
    // -------模拟当次方返回nil , 系统的实现方案
    
    // 系统默认的大头这视图 对应的类 MKPinAnnotationView
    // 大头针标识
    static NSString *pinID = @"pinID";
//    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
    MLAnnotationView *pinView = (MLAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
    // 如果从缓存池取出的大头针视图为空, 就创建
    if (pinView == nil) {
        pinView = [[MLAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinID];
//        pinView.image = [UIImage imageNamed:@"icon_002_cover"];
        
//        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinID];
//        // MKAnnotationView才能设置图片，会替换大头针；MKPinAnnotationView设置image无效
//        pinView.image = [UIImage imageNamed:@"icon_002_cover"];
    }
    
    // 重新设置数据模型 (一定要记得!!!), 为了防止循环利用时, 数据混乱
    pinView.anno = (MLAnnotation *)annotation;
    NSLog(@"%s annotation.type = %lu", __func__, (unsigned long)((MLAnnotation *)annotation).type);
    
    // 控制大头针是否弹框。MLAnnotationView报“Terminating app due to uncaught exception 'NSGenericException', reason: '(null) must implement title, or view (null) must have a non-nil detailCalloutAccessoryView when canShowCallout is YES on corresponding view <MLAnnotationView: 0x104b30560; frame = (-75 -75; 150 150); opaque = NO; layer = <CALayer: 0x282577e20>>'”
//    pinView.canShowCallout = YES;
    
    // 设置大头针颜色
    //    pinView.pinColor = MKPinAnnotationColorGreen;
//    pinView.pinTintColor = [UIColor blackColor]; // iOS9.0
    
    // 设置大头针下落动画
//    pinView.animatesDrop = YES;
    
    
    // 设置大头针显示图片(如果是系统的大头针视图, 那么就无法进行自定义)
    //    pinView.image = [UIImage imageNamed:@"category_1.png"];
//    pinView.image = [UIImage imageNamed:@"icon_002_cover"];
    return pinView;
}

/**
 *  选中大头针视图时调用这个方法
 *
 *  @param mapView 地图
 *  @param view    大头针视图
 */
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"选中---%@", view.annotation.title);
    if([view.annotation isKindOfClass:[MKUserLocation class]])
    {
        return;
    }
    MLAnnotationView *nav = (MLAnnotationView *)view;
    MLAnnotation *annotation = nav.anno;
    
    // 控制区域中心
    CLLocationCoordinate2D center = annotation.coordinate;
    // 设置区域跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.077919, 0.044529);
    
    // 创建一个区域
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    // 设置地图显示区域，这样地图就能以特定尺寸显示当前位置
    [mapView setRegion:region animated:YES];
}

/**
 *  取消选中某个大头针视图
 *
 *  @param mapView 地图
 *  @param view    大头针视图
 */
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"取消选中--%@", view.annotation.title);
}


/**
 *  改变大头针视图拖拽状态时调用
 *
 *  @param mapView  地图
 *  @param view     大头针视图
 *  @param newState 新状态
 *  @param oldState 老状态
 */
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"%zd---%zd", oldState, newState);
}


#pragma mark - Custom Accessors
- (MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        
        _mapView.delegate = self;
        _mapView.showsBuildings = YES;
        _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
        _mapView.showsScale = YES;  // 用户缩放地图到一定比例时才显示
        _mapView.showsCompass = YES;  // 是否显示右上角的指南针
        
        // 显示用户位置，必须要主动请求访问位置权限，否则不会显示用户当前位置
        [self locationM];
        _mapView.showsUserLocation = YES;
        
        _mapView.showsPointsOfInterest = YES;
//    MKMapTypeStandard = 0, // 标准地图
//    MKMapTypeSatellite, // 卫星云图
//    MKMapTypeHybrid, // 混合(在卫星云图上加了标准地图的覆盖层)
//    MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0), // 3D立体
//    MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0), // 3D混合
        _mapView.mapType = MKMapTypeStandard;  // 地图类型，普通地图
        //设置地图可缩放
        _mapView.zoomEnabled = YES;
        //设置地图可滚动
        _mapView.scrollEnabled = YES;
        
        /**
         *  MKUserTrackingModeNone = 0, 不追踪
         MKUserTrackingModeFollow,  追踪
         MKUserTrackingModeFollowWithHeading, 带方向的追踪
         */
        // 不但显示用户位置, 而且还会自动放大地图到合适的比例(也要进行定位授权)
//        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        
        NSLog(@"用户当前是否位于地图中：%d", _mapView.userLocationVisible);
    }
    return _mapView;
}

-(CLLocationManager *)locationM
{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        
        // 如果在设置-隐私-定位服务中关闭定位服务，则输出0，否则输出1
        NSLog(@"locationM locationServicesEnabled：%d", [CLLocationManager locationServicesEnabled]);
        
        // 默认为0；如果关闭设备定位服务或拒绝定位服务，则输出2；如果始终，则输出3
        if (@available(iOS 14.0, *)) {
            NSLog(@"locationM authorizationStatus：%d", [_locationM authorizationStatus]);
        } else {
            NSLog(@"locationM authorizationStatus：%d", [CLLocationManager authorizationStatus]);
        }
        // 必须调用本方法才会弹窗。如果尚未获取过权限，则系统会弹窗；已经获取过或拒绝过，则不会弹窗。
        [_locationM requestAlwaysAuthorization];
    }
    return _locationM;
}

-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

- (UIView *)gotoUserLocationView{
    if(!_gotoUserLocationView){
        _gotoUserLocationView = [[UIView alloc] init];
        _gotoUserLocationView.layer.cornerRadius = 1.5;
        _gotoUserLocationView.layer.masksToBounds = YES;
        _gotoUserLocationView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"my_lcation_disable"];
        [_gotoUserLocationView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@20);
            make.center.equalTo(_gotoUserLocationView);
        }];
    }
    return _gotoUserLocationView;
}

- (UIView *)stationInfoView{
    if (!_stationInfoView) {
        _stationInfoView = [[UIView alloc] init];
        _stationInfoView.backgroundColor = color_neutral_white;
        // 顶部视图，包括上一个任务按钮、下一个任务按钮、切换到任务列表按钮
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = color_neutral_grey_lighter;
        [_stationInfoView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_stationInfoView);
            make.height.equalTo(@28);
        }];
        
        /// 上一个任务按钮
        UIButton *preTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [preTaskButton setImage:[UIImage imageNamed:@"station_last_one"] forState:UIControlStateNormal];
        preTaskButton.backgroundColor = [UIColor clearColor];
        
        [topView addSubview:preTaskButton];
        [preTaskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView).offset(2);
            make.left.equalTo(topView).offset(20);
            make.height.width.equalTo(@24);
        }];
        
        /// 下一个任务按钮
        UIButton *nextTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextTaskButton setImage:[UIImage imageNamed:@"station_next_one"] forState:UIControlStateNormal];
        nextTaskButton.backgroundColor = [UIColor clearColor];
        
        [topView addSubview:nextTaskButton];
        [nextTaskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView).offset(2);
            make.right.equalTo(topView).offset(-20);
            make.height.width.equalTo(@24);
        }];
        
        /// 切换到任务列表按钮
        UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [switchButton setImage:[UIImage imageNamed:@"open_page"] forState:UIControlStateNormal];
        switchButton.backgroundColor = [UIColor clearColor];
        
        [topView addSubview:switchButton];
        [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView).offset(2);
            make.centerX.equalTo(topView);
            make.height.width.equalTo(@24);
        }];
        
        /// 站点名称
        UILabel *stationNameLabel = [[UILabel alloc] init];
        stationNameLabel.font = font_size_sub_title;
        stationNameLabel.textColor = color_neutral_charcoal_dark;
        stationNameLabel.textAlignment = NSTextAlignmentLeft;
        stationNameLabel.text = @"Basic station name";
        [_stationInfoView addSubview:stationNameLabel];
        [stationNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_stationInfoView).offset(24);
            make.top.equalTo(_stationInfoView).offset(40);
            make.height.equalTo(@24);
            make.width.equalTo(@138);
        }];
        
        /// 站点ID内容
        UILabel *stationIDContentLabel = [[UILabel alloc] init];
        stationIDContentLabel.font = font_size_caption;
        stationIDContentLabel.textColor = color_neutral_charcoal_medium;
        stationIDContentLabel.textAlignment = NSTextAlignmentLeft;
        stationIDContentLabel.text = @"498327";
        
        [_stationInfoView addSubview:stationIDContentLabel];
        [stationIDContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView).offset(-8);
            make.centerY.equalTo(stationNameLabel);
            make.height.equalTo(@16);
            make.width.equalTo(@57);
        }];
        
        /// 站点ID标签
        UILabel *stationIDLabel = [[UILabel alloc] init];
        stationIDLabel.font = font_size_caption;
        stationIDLabel.textColor = color_functional_979ba2;
        stationIDLabel.textAlignment = NSTextAlignmentRight;
        stationIDLabel.text = [NSString stringWithFormat:@"%@:", @"Site ID"];
        
        [_stationInfoView addSubview:stationIDLabel];
        [stationIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(stationIDContentLabel.mas_left).offset(-8);
            make.centerY.equalTo(stationNameLabel);
            make.height.equalTo(@24);
            make.width.equalTo(@138);
        }];
        
        UIView *taskTypeView = [[UIView alloc] init];
        taskTypeView.backgroundColor = [UIColor clearColor];
        
        [_stationInfoView addSubview:taskTypeView];
        [taskTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_stationInfoView).offset(76);
            make.left.equalTo(_stationInfoView).offset(24);
            make.right.equalTo(_stationInfoView).offset(-24);
            make.height.equalTo(@16);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = color_functional_ced3db;
        
        [_stationInfoView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_stationInfoView).offset(-32);
            make.left.equalTo(_stationInfoView).offset(24);
            make.right.equalTo(_stationInfoView).offset(-24);
            make.height.equalTo(@0.5);
        }];
        
        /// 站点ID标签
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.font = font_size_caption;
        addressLabel.textColor = color_neutral_charcoal_medium;
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.text = @"218 Tombe-Isso, Paris, 75014, France,Paris, 75014…";
        
        [_stationInfoView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_stationInfoView).offset(24);
            make.right.equalTo(_stationInfoView).offset(-24);
            make.bottom.equalTo(_stationInfoView.mas_bottom);
            make.height.equalTo(@32);
        }];
    }
    return _stationInfoView;
}
@end
