//
//  WebServiceBaseClass.m
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@implementation WebServiceBaseClass

-(id)init
{
    if (self=[super init]) {
        self.strBaseURL=@"http://chosen.sulavmart.com/";
        //self.strBaseURL=@"http://192.168.0.1/Chosen/";
    }
    return self;
}

@end
