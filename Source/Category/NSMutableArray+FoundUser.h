//
//  NSMutableArray+FoundUser.h
//  Chosen
//
//  Created by Kaustav Shee on 4/29/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelUser;

@interface NSMutableArray (FoundUser)

-(ModelUser*)getUserForUserID:(NSString*)strUserID;
-(ModelUser*)getUserForLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude;

@end
