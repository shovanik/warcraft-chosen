//
//  AnnotationViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 2/27/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelUser.h"

@protocol AnnotationViewControllerDelegate <NSObject>

@required
-(ModelUser*)selectedUser;

@optional
-(void)didAnnonationClosePressed;
-(void)didAnnonationAttackPressedWithUser:(ModelUser*)userTapped;


@end

@interface AnnotationViewController : UIViewController

@property(strong,nonatomic) IBOutlet UILabel *lblUserName;
@property(strong,nonatomic) IBOutlet UILabel *lblUserCountry;
@property(strong,nonatomic) IBOutlet UIImageView *imgUser;
@property(strong,nonatomic) IBOutlet UIButton *btnClose;
@property(strong,nonatomic) IBOutlet UIButton *btnAttack;
@property(assign,nonatomic) BOOL isCallOutOpen;

@property(weak,nonatomic) id <AnnotationViewControllerDelegate> delegate;

@end
