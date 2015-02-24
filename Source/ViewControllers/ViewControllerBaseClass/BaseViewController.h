//
//  BaseViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constants.h"

#import "WebService.h"

#import "ModelUser.h"


@interface BaseViewController : UIViewController

@property(assign,nonatomic) BOOL isSlidemenuOpen;

-(void)startLocationManager;
-(void)stopLocationManager;

-(NSDictionary*)addressDictionaryForPlaceMark:(CLPlacemark *)placeMark;

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(void)openSlideMenu;
-(void)closeSlideMenu;
-(IBAction)btnMenuTapped:(id)sender;

@end
