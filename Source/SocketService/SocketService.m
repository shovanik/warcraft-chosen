//
//  SocketService.m
//  Chosen
//
//  Created by Kaustav Shee on 4/27/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "SocketService.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"


@interface SocketService ()<SocketIODelegate>
{
    SocketIO *socketIO;
}

@end

@implementation SocketService

-(id)init
{
    if (self=[super init]) {
        socketIO=[[SocketIO alloc] init];
    }
    return self;
}

+(SocketService*)service
{
    static SocketService *socks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socks=[[SocketService alloc] init];
    });
    return socks;
}

#pragma mark
#pragma mark SocketConnection
#pragma mark

-(void)makeSocketConnectionWithUser:(ModelUser*)myUser Delegate:(id)myDelegate
{
    socketIO.delegate=myDelegate;
    //[socketIO connectToHost:@"192.168.0.133" onPort:8088 withParams:[NSDictionary dictionaryWithObjects:@[myUser.strID,myUser.strUserName] forKeys:@[@"uid",@"name"]]];//For Local Test
    [socketIO connectToHost:@"106.187.95.65" onPort:8088 withParams:[NSDictionary dictionaryWithObjects:@[myUser.strID,myUser.strUserName] forKeys:@[@"uid",@"name"]]];//For remote Test
}

-(void)makeSocketDelegate:(id)myDelegate
{
    socketIO.delegate=myDelegate;
}


@end
