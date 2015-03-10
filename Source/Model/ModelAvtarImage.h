//
//  ModelAvtarImage.h
//  Chosen
//
//  Created by Kaustav Shee on 3/2/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelAvtarImage : ModelBaseClass

@property(strong,nonatomic) NSString *strBigImage;
@property(strong,nonatomic) NSString *strMediumImage;
@property(strong,nonatomic) NSString *strThumbImage;

-(id)initWithDictionary:(NSDictionary*)dict BaseURL:(NSString*)strBaseURL;

@end
