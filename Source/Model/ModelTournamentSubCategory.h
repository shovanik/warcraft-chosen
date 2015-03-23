//
//  ModelTournamentSubCategory.h
//  Chosen
//
//  Created by Kaustav Shee on 3/23/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelTournamentSubCategory : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strCategoryID;
@property(strong,nonatomic) NSString *strTitle;
@property(strong,nonatomic) NSString *strNoOfPlayers;
@property(strong,nonatomic) NSString *strGoldRequired;
@property(strong,nonatomic) NSString *strRadious;
@property(strong,nonatomic) NSString *strPlaytime;
@property(strong,nonatomic) NSString *strGameTypeID;
@property(strong,nonatomic) NSString *strAccessTypeID;
@property(strong,nonatomic) NSString *strCreated;
@property(strong,nonatomic) NSString *strUserID;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
