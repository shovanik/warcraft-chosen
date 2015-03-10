//
//  ModelTerms.h
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelTerms : ModelBaseClass

@property(strong,nonatomic) NSString *strTitle;
@property(strong,nonatomic) NSString *strShortDescription;
@property(strong,nonatomic) NSString *strLongDescription;

-(id)initWithDictionary:(NSDictionary*)dict;


@end
