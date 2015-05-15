//
//  NSMutableArray+FoundUser.m
//  Chosen
//
//  Created by Kaustav Shee on 4/29/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "NSMutableArray+FoundUser.h"
#import "ModelUser.h"

@implementation NSMutableArray (FoundUser)

-(ModelUser*)getUserForUserID:(NSString*)strUserID
{
    for (int i=0; i<self.count; i++) {
        ModelUser *obj=[self objectAtIndex:i];
        if ([obj.strID isEqualToString:strUserID]) {
            return obj;
        }
    }
    return nil;
}

-(ModelUser*)getUserForLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude
{
    for (ModelUser *obj in self) {
        if ([obj.strLatitude floatValue]==latitude && [obj.strLongitude floatValue]==longitude) {
            return obj;
        }
    }
    return nil;
}

@end
