//
//  AttackViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 4/3/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@class ModelUser;
@class SocketIO;
@class SocketIOPacket;

@interface AttackViewController : BaseViewController


@property(strong,nonatomic) ModelUser *userOponents;
@property(assign,nonatomic) BOOL isStartFightReceived;

-(void)didReceiveLocalNotifications:(UILocalNotification *)notification;

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet;

@end
