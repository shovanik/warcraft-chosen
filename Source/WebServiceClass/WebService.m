//
//  LoginService.m
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WebService.h"


typedef enum : NSUInteger {
    LoginService=0,
    RegistrationService,
    UpdateUserService
} WebServiceType;

@implementation WebService

-(id)init
{
    if (self=[super init]) {
//        strLoginURL=@"api/user/login_radius/";
//        strRegistrationURL=@"registration/register";
        strLoginURL=@"api/user/login";
        strRegistrationURL=@"api/user";
        strUpdateURL=@"api/user/update";
    }
    return self;
}
#pragma mark
#pragma mark WebService Helping Method
#pragma mark

-(NSURL*)getURLForService:(WebServiceType)serviceType
{
    NSString *strFinalURL=@"";
    switch (serviceType) {
        case LoginService:
            strFinalURL=[NSString stringWithFormat:@"%@%@",self.strBaseURL,strLoginURL];
            break;
        case RegistrationService:
            strFinalURL=[NSString stringWithFormat:@"%@%@",self.strBaseURL,strRegistrationURL];
            break;
        case UpdateUserService:
            strFinalURL=[NSString stringWithFormat:@"%@%@",self.strBaseURL,strUpdateURL];
            break;
        default:
            strFinalURL=[NSString stringWithFormat:@""];
            break;
    }
    return [NSURL URLWithString:strFinalURL];
}

#pragma mark
#pragma mark WebService Shared Instance
#pragma mark

+(WebService*)service
{
    static WebService *loginService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginService=[[WebService alloc] init];
    });
    return loginService;
}

#pragma mark
#pragma mark Login Service
#pragma mark

-(void)callLoginServiceWithUserName:(NSString*)strUserName Password:(NSString*)strPassword Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"user_name=%@",strUserName]];
    [arr addObject:[NSString stringWithFormat:@"password=%@",strPassword]];
    [arr addObject:[NSString stringWithFormat:@"lat=%@",strLatitude]];
    [arr addObject:[NSString stringWithFormat:@"lon=%@",strLongitude]];
    
    NSString *postParams = [[arr componentsJoinedByString:@"&"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"postParams = %@",postParams);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getURLForService:LoginService] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *RequestPostData = [NSData dataWithBytes: [postParams UTF8String] length: [postParams length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[RequestPostData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:RequestPostData];
    NSOperationQueue *queue=[NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (connectionError) {
                handler(connectionError,YES,@"Connection error is happen, please try again later.");
            }else{
                NSError *error;
                NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    handler(error,YES,@"Login is failed due to some issues, please try again later.");
                }else{
                    BOOL status=[[responseDict objectForKey:@"status"] boolValue];
                    if (status) {
                        NSDictionary *dict=[responseDict objectForKey:@"response"];
                        NSDictionary *dictUserInfo=[dict objectForKey:@"user_info"];
                        NSMutableArray *arrAllUserInfo=[[dict objectForKey:@"all_user_info"] mutableCopy];
                        
                        
                        ModelUser *user=[[ModelUser alloc] initWithDictionary:dictUserInfo];
                        for (int i=0; i<arrAllUserInfo.count; i++) {
                            ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arrAllUserInfo objectAtIndex:i]];
                            [arrAllUserInfo removeObjectAtIndex:i];
                            [arrAllUserInfo insertObject:obj atIndex:i];
                        }
                        NSLog(@"UserInfo = %@",dictUserInfo);
                        NSLog(@"arrAllUserInfo = %@",arrAllUserInfo);
                        
                        NSDictionary *dictResult=[[NSDictionary alloc] initWithObjects:@[user,arrAllUserInfo] forKeys:@[@"User",@"AllUser"]];
                        
                        handler(dictResult,NO,@"User Logged In Successfully !!!");
                    }else{
                        handler(nil,YES,[responseDict objectForKey:@"error"]);
                    }
                }
            }
        });
    }];
}


-(void)callRegistrationServiceWithUserName:(NSString*)strUserName Password:(NSString*)strPassword DateOfBirth:(NSString*)strDateOfBirth Email:(NSString*)strEmail Gender:(NSString*)strGender StateName:(NSString*)strStateName CountryName:(NSString*)strCountrName CityName:(NSString*)strCityName Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"user_name=%@",strUserName]];
    [arr addObject:[NSString stringWithFormat:@"password=%@",strPassword]];
    [arr addObject:[NSString stringWithFormat:@"gender=%@",strGender]];
    [arr addObject:[NSString stringWithFormat:@"email=%@",strEmail]];
    [arr addObject:[NSString stringWithFormat:@"date_of_birth=%@",strDateOfBirth]];
    [arr addObject:[NSString stringWithFormat:@"lat=%@",strLatitude]];
    [arr addObject:[NSString stringWithFormat:@"lon=%@",strLongitude]];
    [arr addObject:[NSString stringWithFormat:@"country_name=%@",strCountrName]];
    [arr addObject:[NSString stringWithFormat:@"state_name=%@",strStateName]];
    [arr addObject:[NSString stringWithFormat:@"city_name=%@",strStateName]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getURLForService:RegistrationService] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *RequestPostData = [NSData dataWithBytes: [postParams UTF8String] length: [postParams length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[RequestPostData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:RequestPostData];
    NSOperationQueue *queue=[NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (connectionError) {
                handler(connectionError,YES,@"Connection error is happen, please try again later.");
            }else{
                NSError *error;
                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    handler(error,YES,@"Registration is failed due to some issues, please try again later.");
                }else{
                    BOOL status=[[responseDict objectForKey:@"status"] boolValue];
                    if (status) {
                        NSDictionary *dict=[responseDict objectForKey:@"response"];
                        NSDictionary *dictUserInfo=[dict objectForKey:@"user_details"];
                        NSMutableArray *arrAllUserInfo=[[dict objectForKey:@"nearby_users"] mutableCopy];
                        ModelUser *user=[[ModelUser alloc] initWithDictionary:dictUserInfo];
                        for (int i=0; i<arrAllUserInfo.count; i++) {
                            ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arrAllUserInfo objectAtIndex:i]];
                            [arrAllUserInfo removeObjectAtIndex:i];
                            [arrAllUserInfo insertObject:obj atIndex:i];
                        }
                        NSLog(@"UserInfo = %@",dictUserInfo);
                        NSLog(@"arrAllUserInfo = %@",arrAllUserInfo);
                        NSDictionary *dictResult=[[NSDictionary alloc] initWithObjects:@[user,arrAllUserInfo] forKeys:@[@"User",@"AllUser"]];
                        handler(dictResult,NO,@"User Registration is completed successfully !!!");
                    }else{
                        handler(nil,YES,@"Registration is failed due to some issues, please try again later.");
                    }
                }
            }
        });
    }];
}

-(void)callUpdateUserserviceWithUserName:(NSString*)strUserName UserID:(NSString*)strUserID DateOfBirth:(NSString*)strDateOfBirth Email:(NSString*)strEmail Gender:(NSString*)strGender StateName:(NSString*)strStateName CountryName:(NSString*)strCountrName CityName:(NSString*)strCityName Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"user_name=%@",strUserName]];
    [arr addObject:[NSString stringWithFormat:@"id=%@",strUserID]];
    [arr addObject:[NSString stringWithFormat:@"gender=%@",strGender]];
    [arr addObject:[NSString stringWithFormat:@"email=%@",strEmail]];
    [arr addObject:[NSString stringWithFormat:@"date_of_birth=%@",strDateOfBirth]];
    [arr addObject:[NSString stringWithFormat:@"lat=%@",strLatitude]];
    [arr addObject:[NSString stringWithFormat:@"lon=%@",strLongitude]];
    [arr addObject:[NSString stringWithFormat:@"country_name=%@",strCountrName]];
    [arr addObject:[NSString stringWithFormat:@"state_name=%@",strStateName]];
    [arr addObject:[NSString stringWithFormat:@"city_name=%@",strStateName]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getURLForService:UpdateUserService] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *RequestPostData = [NSData dataWithBytes: [postParams UTF8String] length: [postParams length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[RequestPostData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:RequestPostData];
    NSOperationQueue *queue=[NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (connectionError) {
                handler(connectionError,YES,@"Connection error is happen, please try again later.");
            }else{
                
                NSLog(@"Response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                
                NSError *error;
                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    handler(error,YES,@"Updation is failed due to some issues, please try again later.");
                }else{
                    BOOL status=[[responseDict objectForKey:@"status"] boolValue];
                    if (status) {
                        NSDictionary *dict=[responseDict objectForKey:@"response"];
                        NSDictionary *dictUserInfo=[dict objectForKey:@"user_details"];
                        NSMutableArray *arrAllUserInfo=[[dict objectForKey:@"nearby_users"] mutableCopy];
                        ModelUser *user=[[ModelUser alloc] initWithDictionary:dictUserInfo];
                        for (int i=0; i<arrAllUserInfo.count; i++) {
                            ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arrAllUserInfo objectAtIndex:i]];
                            [arrAllUserInfo removeObjectAtIndex:i];
                            [arrAllUserInfo insertObject:obj atIndex:i];
                        }
                        NSLog(@"UserInfo = %@",dictUserInfo);
                        NSLog(@"arrAllUserInfo = %@",arrAllUserInfo);
                        NSDictionary *dictResult=[[NSDictionary alloc] initWithObjects:@[user,arrAllUserInfo] forKeys:@[@"User",@"AllUser"]];
                        handler(dictResult,NO,@"User Updation is completed successfully !!!");
                    }else{
                        handler(nil,YES,@"Updation is failed due to some issues, please try again later.");
                    }
                }
            }
        });
    }];
}

@end
