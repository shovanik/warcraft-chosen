//
//  ModelAboutUs.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelAboutUs.h"

@implementation ModelAboutUs

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"title"]&&![[dict objectForKey:@"title"] isKindOfClass:[NSNull class]]) {
            self.strTitle=[dict objectForKey:@"title"];
        }
        if ([dict objectForKey:@"short_description"]&&![[dict objectForKey:@"short_description"] isKindOfClass:[NSNull class]]) {
            self.strShortDescription=[dict objectForKey:@"short_description"];
        }
        if ([dict objectForKey:@"long_description"]&&![[dict objectForKey:@"long_description"] isKindOfClass:[NSNull class]]) {
            self.strLongDescription=[dict objectForKey:@"long_description"];
        }
    }
    return self;
}

@end
