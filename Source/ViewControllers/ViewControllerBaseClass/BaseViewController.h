//
//  BaseViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "DeviceConstant.h"
#import "Constants.h"

#import "WebService.h"

#import "ModelUser.h"
#import "ModelPrivacyPolicy.h"
#import "ModelTerms.h"
#import "ModelAboutUs.h"

#import "GuildImageView.h"

#import "NSMutableArray+FoundGuild.h"


#define __kNetworkUnavailableMessage @"No internet connection is available, please try again later."



@interface BaseViewController : UIViewController

@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property(assign,nonatomic) BOOL isSlidemenuOpen;

@property(assign,nonatomic) BOOL isNetworkRechable;



-(void)startLocationManager;
-(void)stopLocationManager;

-(NSDictionary*)addressDictionaryForPlaceMark:(CLPlacemark *)placeMark;

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(void)openSlideMenu;
-(void)closeSlideMenu;
-(IBAction)btnMenuTapped:(id)sender;

@end