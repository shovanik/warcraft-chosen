//
//  NSMutableArray+FoundGuild.h
//  Chosen
//
//  Created by Kaustav Shee on 3/13/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelGuild.h"

@interface NSMutableArray (FoundGuild)

-(NSInteger)getGuildIndex:(ModelGuild*)guild;

@end
