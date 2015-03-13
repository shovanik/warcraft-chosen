//
//  NSMutableArray+FoundGuild.m
//  Chosen
//
//  Created by Kaustav Shee on 3/13/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "NSMutableArray+FoundGuild.h"

@implementation NSMutableArray (FoundGuild)

-(NSInteger)getGuildIndex:(ModelGuild*)guild
{
    for (int i=0; i<self.count; i++) {
        ModelGuild *obj=[self objectAtIndex:i];
        if ([obj.strId isEqualToString:guild.strId]) {
            return i;
        }
    }
    return -1;
}

@end

