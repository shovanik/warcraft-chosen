//
//  OnlineOfflineTrackerManager.h
//  Chosen
//
//  Created by Kaustav Shee on 6/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineOfflineTrackerManager : NSObject

+(OnlineOfflineTrackerManager*)manager;

-(void)startTrackingUserForUserID:(NSString*)strUserID;

@end
