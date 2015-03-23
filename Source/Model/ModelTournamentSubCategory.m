//
//  ModelTournamentSubCategory.m
//  Chosen
//
//  Created by Kaustav Shee on 3/23/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelTournamentSubCategory.h"

@implementation ModelTournamentSubCategory

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            self.strID=[[dict objectForKey:@"id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strID=@"";
        }
        if ([dict objectForKey:@"category_id"] && ![[dict objectForKey:@"category_id"] isKindOfClass:[NSNull class]]) {
            self.strCategoryID=[[dict objectForKey:@"category_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strCategoryID=@"";
        }
        if ([dict objectForKey:@"title"] && ![[dict objectForKey:@"title"] isKindOfClass:[NSNull class]]) {
            self.strTitle=[[dict objectForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strTitle=@"";
        }
        if ([dict objectForKey:@"no_of_players"] && ![[dict objectForKey:@"no_of_players"] isKindOfClass:[NSNull class]]) {
            self.strNoOfPlayers=[[dict objectForKey:@"no_of_players"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strNoOfPlayers=@"";
        }
        if ([dict objectForKey:@"gold_required"] && ![[dict objectForKey:@"gold_required"] isKindOfClass:[NSNull class]]) {
            self.strGoldRequired=[[dict objectForKey:@"gold_required"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strGoldRequired=@"";
        }
        if ([dict objectForKey:@"radius"] && ![[dict objectForKey:@"radius"] isKindOfClass:[NSNull class]]) {
            self.strRadious=[[dict objectForKey:@"radius"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strRadious=@"";
        }
        if ([dict objectForKey:@"playtime"] && ![[dict objectForKey:@"playtime"] isKindOfClass:[NSNull class]]) {
            self.strPlaytime=[[dict objectForKey:@"playtime"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strPlaytime=@"";
        }
        if ([dict objectForKey:@"game_type_id"] && ![[dict objectForKey:@"game_type_id"] isKindOfClass:[NSNull class]]) {
            self.strGameTypeID=[[dict objectForKey:@"game_type_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strGameTypeID=@"";
        }
        if ([dict objectForKey:@"access_type_id"] && ![[dict objectForKey:@"access_type_id"] isKindOfClass:[NSNull class]]) {
            self.strAccessTypeID=[[dict objectForKey:@"access_type_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strAccessTypeID=@"";
        }
        if ([dict objectForKey:@"created"] && ![[dict objectForKey:@"created"] isKindOfClass:[NSNull class]]) {
            self.strCreated=[[dict objectForKey:@"created"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strCreated=@"";
        }
        if ([dict objectForKey:@"user_id"] && ![[dict objectForKey:@"user_id"] isKindOfClass:[NSNull class]]) {
            self.strUserID=[[dict objectForKey:@"user_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strUserID=@"";
        }
    }
    return self;
}

@end
