//
//  UserLocationChangeViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserLocationChangeViewControllerDelegate <NSObject>

@optional

-(void)locationDidUpdated;

@end

@interface UserLocationChangeViewController : UIViewController

@property(weak,nonatomic) id <UserLocationChangeViewControllerDelegate> delegate;

@end
