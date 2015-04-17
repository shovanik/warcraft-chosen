//
//  AttackViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 4/3/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@class ModelUser;

@interface AttackViewController : BaseViewController


@property(strong,nonatomic) ModelUser *userOponents;

-(void)didReceiveLocalNotifications:(UILocalNotification *)notification;

@end
