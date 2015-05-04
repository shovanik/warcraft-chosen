//
//  SocketService.h
//  Chosen
//
//  Created by Kaustav Shee on 4/27/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketService : NSObject

+(SocketService*)service;

-(void)makeSocketConnectionWithUser:(ModelUser*)myUser Delegate:(id)myDelegate;

@end
