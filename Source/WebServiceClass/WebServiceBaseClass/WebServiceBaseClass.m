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

-(id)init
{
    if (self=[super init]) {
        self.strBaseURL=__kBaseURL;
    }
    return self;
}



@end
