//
//  PrivatePublicConfirmationViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 6/26/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrivatePublicConfirmationViewControllerDelegate <NSObject>

@optional
-(void)didPublicPressed;
-(void)didPrivatePressed;

@end

@interface PrivatePublicConfirmationViewController : UIViewController

@property(weak,nonatomic) id <PrivatePublicConfirmationViewControllerDelegate> delegate;

@end
