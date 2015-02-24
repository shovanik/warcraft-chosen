//
//  CustomLocationManager.m
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "CustomLocationManager.h"

CLPlacemark *placeMarkCurrent;

@implementation CustomLocationManager
@synthesize locationManager;
@synthesize delegate;

-(id)init
{
    if (self=[super init]) {
        locationManager=[[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager requestAlwaysAuthorization];
    }
    return self;
}

#pragma mark
#pragma mark Location Manager Helping Methods
#pragma mark
-(void)startLocationManager
{
    [locationManager startMonitoringSignificantLocationChanges];
}
-(void)stopLocationManager
{
    [locationManager stopMonitoringSignificantLocationChanges];
}


#pragma mark
#pragma mark Location Manager Delegate Methods
#pragma mark

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self stopLocationManager];
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Location Manager Delegate Portion fired Error");
            if (self.delegate && [self.delegate respondsToSelector:@selector(didLocationManagerCompletedWithError:)]) {
                [self.delegate didLocationManagerCompletedWithError:error];
            }
        }else{
            placeMarkCurrent=[placemarks objectAtIndex:0];
            if (placeMarkCurrent) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(didUpdateLocationUpdateWithPlacemark:)]) {
                    [self.delegate didUpdateLocationUpdateWithPlacemark:placeMarkCurrent];
                }
            }
        }
    }];
}


@end
