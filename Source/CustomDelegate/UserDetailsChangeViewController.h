//
//  UserDetailsChangeViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserDetailsChangeViewControllerDelegate <NSObject>

@optional
-(void)userDetailsDidChanged;

@end

@interface UserDetailsChangeViewController : UIViewController

@property(weak,nonatomic) id <UserDetailsChangeViewControllerDelegate> delegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Delegate:(id)delegate;

@end
