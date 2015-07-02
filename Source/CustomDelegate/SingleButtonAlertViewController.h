//
//  SingleButtonAlertViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 6/30/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SingleButtonDelegate <NSObject>

@optional

-(void)didOkPressed;

@end

@interface SingleButtonAlertViewController : UIViewController

@property(weak,nonatomic) id <SingleButtonDelegate> delegate;

+(SingleButtonAlertViewController*)sharedInstance;

-(void)displayMessageWithMessageBody:(NSString*)strMessageBody ButtonTitle:(NSString*)strBtnTitle Delegate:(id<SingleButtonDelegate>)delegate;

@end
