//
//  WebServiceBaseClass.m
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WebServiceBaseClass.h"
#import "WebServiceConstant.h"



@implementation WebServiceBaseClass

@synthesize strBaseURL;

-(id)init
{
    if (self=[super init]) {
        strBaseURL=__kBaseURL;
    }
    return self;
}

-(NSURL*)getTotalURL:(NSString*)strAPIURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",strBaseURL,strAPIURL]];
}


@end
