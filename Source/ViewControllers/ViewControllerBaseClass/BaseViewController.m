//
//  BaseViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

#import "CustomLocationManager.h"
#import "SlideOutMenuViewController.h"

#import "WorldMapViewController.h"


@interface BaseViewController ()<CustomLocationManagerDelegate,SlideOutMenuDelegate>
{
    CustomLocationManager *locationManager;
    
    //IBOutlet UIView *sidePanelViewController;
    
    
}

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



@end
