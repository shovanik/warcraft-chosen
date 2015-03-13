//
//  WebServiceBaseClass.h
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^CompletionHandler)(id result,BOOL isError,NSString *strMessage);

@interface WebServiceBaseClass : NSObject

@property(strong,nonatomic) NSString *strBaseURL;

@end
