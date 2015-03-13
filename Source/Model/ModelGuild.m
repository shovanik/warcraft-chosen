//
//  ModelGuild.m
//  Chosen
//
//  Created by Kaustav Shee on 3/11/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelGuild.h"

@implementation ModelGuild
@synthesize strAccuracy;
@synthesize strDamage;
@synthesize strGuildImage;
@synthesize strId;
@synthesize strName;
@synthesize strPrice;
@synthesize strRating;

-(id)initWithDictionary:(NSDictionary*)dict WithBaseURL:(NSString*)strBaseURL
{
    if (self=[super init]) {
        
        if ([dict objectForKey:@"id"]&& ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            strId=[dict objectForKey:@"id"];
        }else{
            strId=@"";
        }
        
        if ([dict objectForKey:@"name"]&& ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            strName=[dict objectForKey:@"name"];
        }else{
            strName=@"";
        }
        
        if ([dict objectForKey:@"damage"]&& ![[dict objectForKey:@"damage"] isKindOfClass:[NSNull class]]) {
            strDamage=[[dict objectForKey:@"damage"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            strDamage=@"0";
        }
        
        if ([dict objectForKey:@"accuracy"]&& ![[dict objectForKey:@"accuracy"] isKindOfClass:[NSNull class]]) {
            strAccuracy=[[dict objectForKey:@"accuracy"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            strAccuracy=@"0";
        }
        
        if ([dict objectForKey:@"rating"]&& ![[dict objectForKey:@"rating"] isKindOfClass:[NSNull class]]) {
            strRating=[dict objectForKey:@"rating"];
        }else{
            strRating=@"0";
        }

        if ([dict objectForKey:@"price"]&& ![[dict objectForKey:@"price"] isKindOfClass:[NSNull class]]) {
            strPrice=[dict objectForKey:@"price"];
        }else{
            strPrice=@"";
        }
        
        if ([dict objectForKey:@"guild_image"]&& ![[dict objectForKey:@"guild_image"] isKindOfClass:[NSNull class]]) {
            strGuildImage=[NSString stringWithFormat:@"%@%@",strBaseURL,[dict objectForKey:@"guild_image"]];
        }else{
            strGuildImage=@"";
        }
    }
    return self;
}

@end
