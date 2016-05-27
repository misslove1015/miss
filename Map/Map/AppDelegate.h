//
//  AppDelegate.h
//  Map
//
//  Created by miss on 15/10/15.
//  Copyright © 2015年 mukr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager *_mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

