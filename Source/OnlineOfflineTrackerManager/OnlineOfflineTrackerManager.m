//
//  OnlineOfflineTrackerManager.m
//  Chosen
//
//  Created by Kaustav Shee on 6/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "OnlineOfflineTrackerManager.h"

@interface OnlineOfflineTrackerManager ()
{
    @private
    
    NSOperationQueue *myQueue;
}

@end

@implementation OnlineOfflineTrackerManager

-(id)init
{
    if (self=[super init]) {
        
        
        
    }
    return self;
}

+(OnlineOfflineTrackerManager*)manager
{
    static OnlineOfflineTrackerManager *trackerManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        trackerManager=[[OnlineOfflineTrackerManager alloc] init];
    });
    return trackerManager;
}

-(void)startTrackingUserForUserID:(NSString*)strUserID
{
    myQueue=[[NSOperationQueue alloc] init];
    [myQueue setName:@"OnlineTrackingQueue"];
    [myQueue setMaxConcurrentOperationCount:1];
    
    NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(callUserTrackingForUserID:) object:strUserID];
    [myQueue addOperation:operation];
}


-(void)callUserTrackingForUserID:(NSString*)strUserID
{
    [[WebService service] callLastSeenServiceForUserID:strUserID WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        NSLog(@"response = %@",strMessage);
        [NSThread sleepForTimeInterval:10];
        [self startTrackingUserForUserID:strUserID];
    }];
}

@end
