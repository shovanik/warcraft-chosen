//
//  ModelTournamentCategory.h
//  Chosen
//
//  Created by Kaustav Shee on 3/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelTournamentCategory : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strName;
@property(strong,nonatomic) NSString *strCreated;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
