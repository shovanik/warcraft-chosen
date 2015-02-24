//
//  AppDelegate.h
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationcontroller;

-(void)localnotification;
@end

