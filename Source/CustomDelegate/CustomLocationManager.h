//
//  CustomLocationManager.h
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomLocationManagerDelegate <NSObject>

@optional
-(void)didUpdateLocationUpdateWithPlacemark:(CLPlacemark*)placeMark;
-(void)didLocationManagerCompletedWithError:(NSError*)error;

@end

@interface CustomLocationManager : NSObject<CLLocationManagerDelegate>

@property(strong,nonatomic) CLLocationManager *locationManager;
@property(weak,nonatomic) id <CustomLocationManagerDelegate> delegate;

#pragma mark
#pragma mark Location Manager Helping Methods
#pragma mark
-(void)startLocationManager;
-(void)stopLocationManager;

@end
