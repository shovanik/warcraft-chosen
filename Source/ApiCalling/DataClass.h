//
//  DataClass.h
//  Kicka
//
//  Created by Cygnus Infomedia on 4/8/14.
//  Copyright (c) 2014 cygnusimfomedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject
{
    
    NSString *ROOT_LOCATION;
    NSString *REG_API_LOCATION;
    NSString *LOGIN_API_LOCATION;
    NSString *RADIOUS_API_LOCATION;
    NSString *SITE_LOCATION;
}
@property(nonatomic,retain)NSString *USER_NO;
@property(nonatomic,retain)NSDictionary *reponseValue;
//@property(nonatomic,assign) BOOL isLoginButtonClicked;
@property(nonatomic,assign) NSInteger isApiCalled;

+(DataClass*)getInstance;

- (NSString*) RootLocation;
- (NSString*) RegApiLocation;
- (NSString*) LoginApiLocation;
- (NSString*) RadiousApiLocation;
- (NSString*) SiteLocation;
- (void)apiCall: (NSDictionary *)params method:(NSString*) method  completionHandler:(void (^)(id , NSError *))completionBlock;
@end

