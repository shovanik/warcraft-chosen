//
//  BaseViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

#include<unistd.h>
#include<netdb.h>

#import "CustomLocationManager.h"
#import "SlideOutMenuViewController.h"

#import "WorldMapViewController.h"

#import "WebServiceConstant.h"

@interface BaseViewController ()<CustomLocationManagerDelegate,SlideOutMenuDelegate>
{
    CustomLocationManager *locationManager;
}

@property(strong) Reachability * googleReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;


@end

@implementation BaseViewController

#pragma mark
#pragma mark Initialization Methods
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark
#pragma mark DateFormat String Initialization
#pragma mark
    strDateFormat=@"yyyy-MM-dd";
#pragma mark
#pragma mark DateFormatter Initialization
#pragma mark
    dateFormattter=[[NSDateFormatter alloc] init];
    [dateFormattter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormattter setDateFormat:strDateFormat];
#pragma mark
#pragma mark Activity Indicator Initialization
#pragma mark
    
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
#pragma mark
#pragma mark Side Panel Initialization
#pragma mark
    
    slideMenu.delegate=self;
    _isSlidemenuOpen=NO;
    
#pragma mark
#pragma mark Location Manager Initialization
#pragma mark
    
    locationManager=[[CustomLocationManager alloc] init];
    locationManager.delegate=self;
    
#pragma mark
#pragma mark Rechability Initialization
#pragma mark
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

    __weak __block typeof(self)weakself=self;
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a Reachability object for www.google.com
    
    self.googleReach = [Reachability reachabilityWithHostname:__kHostName];
    
    self.googleReach.reachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Rechable", __kHostName]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            weakself.isNetworkRechable=YES;
        }];
    };
    
    self.googleReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Rechable", __kHostName]);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=NO;
        });
    };
    
    [self.googleReach startNotifier];
    
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a reachability for the local WiFi
    
    self.localWiFiReach = [Reachability reachabilityForLocalWiFi];
    
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    self.localWiFiReach.reachableOnWWAN = NO;
    
    self.localWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Rechable", __kHostName]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=YES;
        });
    };
    
    self.localWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Rechable", __kHostName]);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=NO;
        });
    };
    
    [self.localWiFiReach startNotifier];
    
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a Reachability object for the internet
    
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    
    self.internetConnectionReach.reachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Rechable", __kHostName]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=YES;
        });
    };
    
    self.internetConnectionReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Rechable", __kHostName]);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=NO;
        });
    };
    
    [self.internetConnectionReach startNotifier];
    
    
#pragma mark
#pragma mark Shadow Set
#pragma mark
    
    CALayer *layer = self.navigationController.view.layer;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor darkTextColor] CGColor];
    layer.shadowRadius = 10.0f;
    layer.shadowOpacity = 1.0f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark
#pragma mark Common IBAction
#pragma mark

-(IBAction)btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnMenuTapped:(id)sender
{
    if (self.isSlidemenuOpen) {
        [self closeSlideMenu];
    }else{
        [self openSlideMenu];
    }
}

#pragma mark
#pragma mark Location Manager Helping Methods
#pragma mark

-(void)startLocationManager
{
    [locationManager startLocationManager];
}
-(void)stopLocationManager
{
    [locationManager stopLocationManager];
}

-(NSDictionary*)addressDictionaryForPlaceMark:(CLPlacemark*)placeMark
{
    NSDictionary *dict=placeMark.addressDictionary;
    NSMutableDictionary *resultDict=[[NSMutableDictionary alloc] init];
    [resultDict setObject:[dict objectForKey:@"City"] forKey:@"City"];
    [resultDict setObject:[dict objectForKey:@"Country"] forKey:@"Country"];
    [resultDict setObject:[dict objectForKey:@"State"] forKey:@"State"];
    [resultDict setObject:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.latitude] forKey:@"Latitude"];
    [resultDict setObject:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.longitude] forKey:@"Longitude"];
    return [NSDictionary dictionaryWithDictionary:resultDict];
}

#pragma mark
#pragma mark Custom Location Manager Delegate Methods
#pragma mark

-(void)didLocationManagerCompletedWithError:(NSError *)error
{
    NSLog(@"Error = %@",[error description]);
}

-(void)didUpdateLocationUpdateWithPlacemark:(CLPlacemark *)placeMark
{
    NSLog(@"%@",[self addressDictionaryForPlaceMark:placeMark]);
}

#pragma mark
#pragma mark Email Validation
#pragma mark

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
#pragma mark
#pragma mark Slide Menu Helping method
#pragma mark

-(void)openSlideMenu
{
    if (!_isSlidemenuOpen) {
        UIWindow *window=[[UIApplication sharedApplication] keyWindow];
        [UIView animateWithDuration:0.5 animations:^{
            window.rootViewController.view.frame=CGRectMake(window.frame.size.width-50, 0, window.frame.size.width, window.frame.size.height);
        } completion:^(BOOL finished) {
            _isSlidemenuOpen=YES;
        }];
    }
}
-(void)closeSlideMenu
{
    if (_isSlidemenuOpen) {
        UIWindow *window=[[UIApplication sharedApplication] keyWindow];
        [UIView animateWithDuration:0.5 animations:^{
            window.rootViewController.view.frame=CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
        } completion:^(BOOL finished) {
            _isSlidemenuOpen=NO;
        }];
    }
}



#pragma mark
#pragma mark Slide Menu Delegate
#pragma mark

-(void)didWorlMapClicked
{
    NSLog(@"didWorlMapClicked");
    [self closeSlideMenu];
}
-(void)didGuildClicked
{
    NSLog(@"didGuildClicked");
    [self closeSlideMenu];
}

-(void)didContractClicked
{
    NSLog(@"didContractClicked");
    [self closeSlideMenu];
}
-(void)didTournamentClicked
{
    NSLog(@"didTournamentClicked");
    [self closeSlideMenu];
}
-(void)didSettingsClicked
{
    NSLog(@"didSettingsClicked");
    [self closeSlideMenu];
}

#pragma mark
#pragma mark Slide Menu Delegate
#pragma mark

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if(reach == self.googleReach)
    {
        if([reach isReachable])
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Reachable", __kHostName]);
            self.isNetworkRechable=YES;
        }
        else
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Reachable", __kHostName]);
            self.isNetworkRechable=NO;
        }
    }
    else if (reach == self.localWiFiReach)
    {
        if([reach isReachable])
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Reachable", __kHostName]);
            self.isNetworkRechable=YES;
        }
        else
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Reachable", __kHostName]);
            self.isNetworkRechable=NO;
        }
    }
    else if (reach == self.internetConnectionReach)
    {
        if([reach isReachable])
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Reachable", __kHostName]);
            self.isNetworkRechable=YES;
        }
        else
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Reachable", __kHostName]);
            self.isNetworkRechable=NO;
        }
    }
}

@end
