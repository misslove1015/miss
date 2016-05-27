//
//  ViewController.m
//  Map
//
//  Created by miss on 15/10/15.
//  Copyright © 2015年 mukr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<BMKPoiSearchDelegate>
{
    BMKLocationService  *_locService;
    BMKGeoCodeSearch    *_searcher;
    BMKPoiSearch        *_search;
    BOOL                _isLoaction;
    CGFloat             _latitude;
    CGFloat             _longitude;
    NSMutableString     *_string;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _searcher = [[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
   
}

- (IBAction)searchNear:(id)sender {
     _string = [[NSMutableString alloc]init];
    _search =[[BMKPoiSearch alloc]init];
    _search.delegate = self;
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    //option.location = CLLocationCoordinate2D{39.915, 116.404};
    option.location = CLLocationCoordinate2DMake(_latitude, _longitude);
    if (_textField.text.length > 0) {
        option.keyword = _textField.text;
    }else{
        option.keyword = @"写字楼";
    }
    BOOL flag = [_search poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    

}

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error{

    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSArray *array = poiResultList.poiInfoList;
        for (BMKPoiInfo *info in array) {
            [_string appendString:[NSString stringWithFormat:@"%@\n",info.name]];
            
        }
        _textView.text = _string;
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)searchNearby{
   
}


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    if (!_isLoaction) {
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        _latitude = userLocation.location.coordinate.latitude;
        _longitude = userLocation.location.coordinate.longitude;
      
        _numberLabel.text = [NSString stringWithFormat:@"纬度%.2f  经度%.2f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        
        BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                                BMKReverseGeoCodeOption alloc]init];
        reverseGeoCodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
        
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
        

    }
    
    _isLoaction = YES;
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      _addressLabel.text = result.address;
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

//不使用时将delegate设置为 nil
- (void)viewWillDisappear:(BOOL)animated{
    _searcher.delegate = nil;
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"%@", error);
    //Error Domain=kCLErrorDomain Code=0 "The operation couldn’t be completed. (kCLErrorDomain error 0.)"
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
