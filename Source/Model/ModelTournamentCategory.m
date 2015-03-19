//
//  ModelTournamentCategory.m
//  Chosen
//
//  Created by Kaustav Shee on 3/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelTournamentCategory.h"

@implementation ModelTournamentCategory

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            self.strID=[dict objectForKey:@"id"];
        }
        if ([dict objectForKey:@"name"] && ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            self.strName=[dict objectForKey:@"name"];
        }
        if ([dict objectForKey:@"created"] && ![[dict objectForKey:@"created"] isKindOfClass:[NSNull class]]) {
            self.strCreated=[dict objectForKey:@"created"];
        }
    }
    return self;
}

@end
