//
//  CustomConfirmationViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 4/3/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomConfirmationViewControllerDelegate <NSObject>

@optional

-(void)didYesPressed;
-(void)didNoPressed;

@end
@interface CustomConfirmationViewController : UIViewController

@property(weak,nonatomic) id <CustomConfirmationViewControllerDelegate> delegate;

@end
