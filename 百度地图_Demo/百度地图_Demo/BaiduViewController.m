//
//  BaiduViewController.m
//  百度地图_Demo
//
//  Created by 郭乐峰 on 2017/4/10.
//  Copyright © 2017年 niuniu. All rights reserved.
//

#import "BaiduViewController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h> //引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h> //引入定位功能所有的头文件

@interface BaiduViewController ()
<
BMKMapViewDelegate,
BMKLocationServiceDelegate
>
{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
}

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) BOOL isOpenLocation; // 是否打开定位
@property (nonatomic, strong) UILabel *myLocationLabel; // 位置详细信息
@end

@implementation BaiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isOpenLocation = YES;
    
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.mapType = BMKMapTypeStandard; // 设置为标准图
    self.view = _mapView;
    
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self; // 定位
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;
    // 定位模式
    _mapView.userTrackingMode = BMKUserTrackingModeHeading;
    
    [self createLocationButton];
    [self createDetailLocationLabel];
    
}
// 定位按钮
- (void)createLocationButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_mapView.frame.size.width - 35, _mapView.frame.size.height - 35, 30, 30);
    [button setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColor.clearColor;
    [_mapView addSubview:button];
}
// 显示当前位置的详细信息的Label
- (void)createDetailLocationLabel {
    self.myLocationLabel = [[UILabel alloc] init];
    _myLocationLabel.frame = CGRectMake(0, 70, _mapView.frame.size.width, 30);
    _myLocationLabel.backgroundColor = [UIColor clearColor];
    _myLocationLabel.textAlignment = NSTextAlignmentCenter;
    [_mapView addSubview:_myLocationLabel];
}

- (void)locationClick {
    if (!_isOpenLocation) {
        NSLog(@"开启");
        // 启动 LocationService
        [_locService startUserLocationService];
        _mapView.showsUserLocation = YES;
        // 定位模式
        _mapView.userTrackingMode = BMKUserTrackingModeHeading;
        
        _isOpenLocation = !_isOpenLocation;
    } else {
        NSLog(@"关闭");
        // 关闭
        [_locService stopUserLocationService];
        _mapView.showsUserLocation = NO;
        _isOpenLocation = !_isOpenLocation;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    // 此处记得不用的时候需要置nil, 否侧影响内存的释放
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = nil; // 不用时置nil
}

- (void)willStartLocatingUser {
    NSLog(@"开始定位");
}
- (void)didStopLocatingUser {
    NSLog(@"停止定位");
}
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"定位失败 error: %@", error);
}

// 用户方向更新后, 会调用此函数
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"heading is %@", userLocation.heading);
    [_mapView updateLocationData:userLocation];
    _latitude = userLocation.location.coordinate.latitude;
    _longitude = userLocation.location.coordinate.longitude;
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f, long %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _latitude = userLocation.location.coordinate.latitude;
    _longitude = userLocation.location.coordinate.longitude;
    
    [self getCity:userLocation.location]; // 获取userLocation传到下面
}

- (void)getCity:(CLLocation *)location {
    // 地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if (placemark.subLocality != nil) {
            NSString *cityName = placemark.locality; // 城市
            NSString *areaName = placemark.subLocality; // 区
            NSString *thoroughfareName = placemark.thoroughfare; // 街道
            NSString *numberName = placemark.subThoroughfare;
            NSLog(@"%@", numberName);
            NSString *detailName;
            if (numberName) {
                detailName = [NSString stringWithFormat:@"%@-%@-%@-%@", cityName, areaName, thoroughfareName, numberName];
            } else {
                
                detailName = [NSString stringWithFormat:@"%@-%@-%@", cityName, areaName, thoroughfareName];
            }
            
            _myLocationLabel.text = detailName;
        }
    }];
}

@end
