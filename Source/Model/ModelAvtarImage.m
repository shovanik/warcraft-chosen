//
//  ModelAvtarImage.m
//  Chosen
//
//  Created by Kaustav Shee on 3/2/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelAvtarImage.h"

@implementation ModelAvtarImage

@synthesize strBigImage;
@synthesize strMediumImage;
@synthesize strThumbImage;

-(id)initWithDictionary:(NSDictionary*)dict BaseURL:(NSString*)strBaseURL
{
    if (self=[super init]) {
        if (![dict isKindOfClass:[[NSNull null] class]]) {
            if ([dict objectForKey:@"big"]) {
                self.strBigImage=[NSString stringWithFormat:@"%@%@",strBaseURL,[dict objectForKey:@"big"]];
            }else{
                self.strBigImage=@"";
            }
            
            if ([dict objectForKey:@"medium"]) {
                self.strMediumImage=[NSString stringWithFormat:@"%@%@",strBaseURL,[dict objectForKey:@"medium"]];
            }else{
                self.strMediumImage=@"";
            }
            
            if ([dict objectForKey:@"thumb"]) {
                self.strThumbImage=[NSString stringWithFormat:@"%@%@",strBaseURL,[dict objectForKey:@"thumb"]];
            }else{
                self.strThumbImage=@"";
            }
        }else{
            self.strBigImage=@"";
            self.strMediumImage=@"";
            self.strThumbImage=@"";
        }
    }
    return self;
}

@end
