//
//  ModelGuild.h
//  Chosen
//
//  Created by Kaustav Shee on 3/11/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelGuild : ModelBaseClass

@property(strong,nonatomic) NSString *strId;
@property(strong,nonatomic) NSString *strName;
@property(strong,nonatomic) NSString *strDamage;
@property(strong,nonatomic) NSString *strAccuracy;
@property(strong,nonatomic) NSString *strRating;
@property(strong,nonatomic) NSString *strPrice;
@property(strong,nonatomic) NSString *strGuildImage;

-(id)initWithDictionary:(NSDictionary*)dict WithBaseURL:(NSString*)strBaseURL;

@end
