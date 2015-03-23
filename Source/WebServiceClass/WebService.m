//
//  LoginService.m
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WebService.h"
#import "ModelUser.h"
#import "ModelPrivacyPolicy.h"
#import "ModelAboutUs.h"
#import "ModelTerms.h"
#import "ModelGuild.h"
#import "ModelTournamentCategory.h"


typedef enum : NSUInteger {
    LoginService=0,
    RegistrationService,
    UpdateUserService,
    UploadAvtarService,
    ResetPassword,
    LastSeen,
    NearByUser,
    PrivacyPolicy,
    AboutUS,
    TermsConditions,
    ForgetPassword,
    GetAllGuild,
    GetSpecificGuild,
    AddGuid,
    GetSpecificUserGuilds,
    GetTournamentCategory,
    GetNearTournament
} WebServiceType;

static NSString *const allServices[]={
    [LoginService]=@"api/user/login",
    [RegistrationService]=@"api/user",
    [UpdateUserService]=@"api/user/update",
    [UploadAvtarService]=@"dfwefsdfds",
    [ResetPassword]=@"api/user/old_password",
    [LastSeen]=@"api/user/lastseen",
    [NearByUser]=@"api/user/nearbyuser",
    [PrivacyPolicy]=@"api/pages",
    [AboutUS]=@"api/pages",
    [TermsConditions]=@"api/pages",
    [ForgetPassword]=@"api/user/forgot_password",
    [GetAllGuild]=@"api/guild",
    [GetSpecificGuild]=@"api/guild/id",
    [AddGuid]=@"api/user/add_guild",
    [GetSpecificUserGuilds]=@"api/user/guilds",
    [GetTournamentCategory]=@"api/tournament/tournaments_category",
    [GetNearTournament]=@"api/tournament/near_tournament"
};

@implementation WebService

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[LoginService]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                        
                        
                        ModelUser *user=[[ModelUser alloc] initWithDictionary:dictUserInfo BaseURL:self.strBaseURL];
                        for (int i=0; i<arrAllUserInfo.count; i++) {
                            ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arrAllUserInfo objectAtIndex:i] BaseURL:self.strBaseURL];
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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[RegistrationService]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                        ModelUser *user=[[ModelUser alloc] initWithDictionary:dictUserInfo BaseURL:self.strBaseURL];
                        for (int i=0; i<arrAllUserInfo.count; i++) {
                            ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arrAllUserInfo objectAtIndex:i] BaseURL:self.strBaseURL];
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
    [arr addObject:[NSString stringWithFormat:@"city_name=%@",strCityName]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[UpdateUserService]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                        ModelUser *user=[[ModelUser alloc] initWithDictionary:dictUserInfo BaseURL:self.strBaseURL];
                        for (int i=0; i<arrAllUserInfo.count; i++) {
                            ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arrAllUserInfo objectAtIndex:i] BaseURL:self.strBaseURL];
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
-(void)callUploadAvtarImageforUserID:(NSString*)strUserID AvtarImage:(NSData*)imgData WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[UploadAvtarService]]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body=[NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    // Set Image Data
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"avtar.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imgData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set User ID.
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userid\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[strUserID dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSOperationQueue *myQueue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:myQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            handler(connectionError,YES,@"Connection error happen, please try again later.");
        }else{
            
        }
    }];
}
-(void)callResetPasswordServiceForUserID:(NSString*)strUserID NewPassword:(NSString*)strNewPassword OldPassword:(NSString*)strOldPassword WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"new_password=%@",strNewPassword]];
    [arr addObject:[NSString stringWithFormat:@"confirm_password=%@",strNewPassword]];
    [arr addObject:[NSString stringWithFormat:@"password=%@",strOldPassword]];
    [arr addObject:[NSString stringWithFormat:@"id=%@",strUserID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[ResetPassword]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    handler(error,YES,@"Reset Password is failed due to some issues, please try again later.");
                }else{
                    if ([[responseDict objectForKey:@"status"] boolValue]) {
                        handler(nil,NO,@"Password changed successfully !!!");
                    }else{
                        handler(nil,YES,[responseDict objectForKey:@"error"]);
                    }
                }
            }
        });
    }];
}
-(void)callLastSeenServiceForUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"id=%@",strUserID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[LastSeen]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                handler(nil,NO,@"callLastSeenServiceForUserID Service excuted successfully.");
            }
        });
    }];
}
-(void)callNearByUserServiceForUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"id=%@",strUserID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[NearByUser]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    handler(error,YES,@"Something is wrong, please try again later.");
                }else{
                    if ([[responseDict objectForKey:@"status"] boolValue]) {
                        if ([[responseDict objectForKey:@"response"] isKindOfClass:[NSArray class]]) {
                            NSMutableArray *arr=[[responseDict objectForKey:@"response"] mutableCopy];
                            for (int i=0; i<arr.count; i++) {
                                ModelUser *obj=[[ModelUser alloc] initWithDictionary:[arr objectAtIndex:i] BaseURL:self.strBaseURL];
                                if (obj) {
                                    [arr removeObjectAtIndex:i];
                                    [arr insertObject:obj atIndex:i];
                                }
                            }
                            handler(arr,NO,@"All the near by user is tracked successfully");
                        }
                    }
                }
            }
        });
    }];
}
-(void)callAboutUsServiceWithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"page=about"]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[AboutUS]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    if ([[responseDict objectForKey:@"error"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
                        if ([responseDict objectForKey:@"details"]&&![[responseDict objectForKey:@"details"] isKindOfClass:[NSNull class]]) {
                            handler([[ModelAboutUs alloc] initWithDictionary:[responseDict objectForKey:@"details"]],NO,@"About US is successfully received.");
                        }else{
                            handler(nil,YES,@"Something is wrong, please try again later.");
                        }
                    }else{
                        handler(nil,YES,@"Something is wrong, please try again later.");
                    }
                }
            }
        });
    }];
}
-(void)callPrivacyPolicyWithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"page=privacy"]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[PrivacyPolicy]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    if ([[responseDict objectForKey:@"error"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
                        if ([responseDict objectForKey:@"details"]&&![[responseDict objectForKey:@"details"] isKindOfClass:[NSNull class]]) {
                            handler([[ModelPrivacyPolicy alloc] initWithDictionary:[responseDict objectForKey:@"details"]],NO,@"About US is successfully received.");
                        }else{
                            handler(nil,YES,@"Something is wrong, please try again later.");
                        }
                    }else{
                        handler(nil,YES,@"Something is wrong, please try again later.");
                    }
                }
            }
        });
    }];
}
-(void)callTermsAndConditionWithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"page=terms"]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[TermsConditions]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    if ([[responseDict objectForKey:@"error"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
                        if ([responseDict objectForKey:@"details"]&&![[responseDict objectForKey:@"details"] isKindOfClass:[NSNull class]]) {
                            handler([[ModelTerms alloc] initWithDictionary:[responseDict objectForKey:@"details"]],NO,@"Terms and Condition is Successfully Received.");
                        }else{
                            handler(nil,YES,@"Something is wrong, please try again later.");
                        }
                    }else{
                        handler(nil,YES,@"Something is wrong, please try again later.");
                    }
                }
            }
        });
    }];
}
-(void)callForgetPasswordServiceForEmailID:(NSString*)strEmailID withCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"email=%@",strEmailID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[ForgetPassword]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    if ([[responseDict objectForKey:@"status"] isEqualToString:@"1"]) {
                        handler(nil,NO,[responseDict objectForKey:@"details"]);
                    }else{
                        handler(nil,YES,@"Something is wrong, please try again later.");
                    }
                }
            }
        });
    }];
}
-(void)callGetAllGuildWithCompletionHandler:(CompletionHandler)handler
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[GetAllGuild]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSString *postParams=@"";
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
                
                //NSLog(@"Response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                
                NSError *error;
                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    handler(error,YES,@"Something is wrong, please try agian later.");
                }else{
                    if (![[responseDict objectForKey:@"status"] boolValue]) {
                        handler(nil,NO,@"Something is wrong, please try agian later.");
                    }else{
                        NSMutableArray *arrGuild=[[responseDict objectForKey:@"response"] mutableCopy];
                        for (int i=0; i<arrGuild.count; i++) {
                            ModelGuild *guild=[[ModelGuild alloc] initWithDictionary:[arrGuild objectAtIndex:i] WithBaseURL:self.strBaseURL];
                            [arrGuild removeObjectAtIndex:i];
                            [arrGuild insertObject:guild atIndex:i];
                        }
                        handler(arrGuild,NO,@"Guild have received properly.");
                    }
                }
            }
        });
    }];
}
-(void)callGetGuildForGuildID:(NSString*)strGuildID WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"id=%@",strGuildID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[GetSpecificGuild]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    handler(error,YES,@"Something is wrong, please try agian later.");
                }else{
                    if (![[responseDict objectForKey:@"status"] boolValue]) {
                        handler(nil,NO,@"Something is wrong, please try agian later.");
                    }else{
                        handler([[ModelGuild alloc] initWithDictionary:[responseDict objectForKey:@"response"] WithBaseURL:self.strBaseURL],NO,@"Guild Received Successfully");
                    }
                }
            }
        });
    }];
}
-(void)callGetGuildsForUserId:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"user_id=%@",strUserID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[GetSpecificUserGuilds]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                
                //NSLog(@"Response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                NSError *error;
                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    handler(error,YES,@"Something is wrong, please try agian later.");
                }else{
                    if (![[responseDict objectForKey:@"status"] boolValue]) {
                        handler(nil,NO,@"Something is wrong, please try agian later.");
                    }else{
                        NSMutableArray *arrResponse=[[responseDict objectForKey:@"response"] mutableCopy];
                        for (int i=0; i<arrResponse.count; i++) {
                            ModelGuild *guild=[[ModelGuild alloc] initWithDictionary:[arrResponse objectAtIndex:i] WithBaseURL:self.strBaseURL];
                            [arrResponse removeObjectAtIndex:i];
                            [arrResponse insertObject:guild atIndex:i];
                        }
                        handler(arrResponse,NO,@"Guild For User Received");
                    }
                }
            }
        });
    }];
}
-(void)callAddGuildForGuildID:(NSString*)strGuildID UserID:(NSString*)strUserID CompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"user_id=%@",strUserID]];
    [arr addObject:[NSString stringWithFormat:@"guild_id=%@",strGuildID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[AddGuid]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                    handler(error,YES,@"Something is wrong, please try agian later.");
                }else{
                    if ([[responseDict objectForKey:@"status"] boolValue]) {
                        handler(nil,NO,@"Guild is successfully added to the user.");
                    }else{
                        handler(nil,YES,@"Something is wrong, please try agian later.");
                    }
                }
            }
        });
    }];
}

-(void)callGetTournamentCategoryWithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[GetTournamentCategory]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                NSLog(@"callGetTournamentCategoryWithCompletionHandler Response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                NSError *error;
                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                if (error) {
                    handler(error,YES,@"Something is wrong, please try agian later.");
                }else{
                    if ([[responseDict objectForKey:@"status"] boolValue]) {
                        responseDict=[responseDict objectForKey:@"response"];
                        NSMutableArray *arrTemp=[[responseDict objectForKey:@"category_tournaments"] mutableCopy];
                        for (int i=0; i<arrTemp.count; i++) {
                            ModelTournamentCategory *obj=[[ModelTournamentCategory alloc] initWithDictionary:[arrTemp objectAtIndex:i]];
                            NSLog(@"Object = %@",[arrTemp objectAtIndex:i]);
                            [arrTemp removeObjectAtIndex:i];
                            [arrTemp insertObject:obj atIndex:i];
                        }
                        handler(arrTemp,NO,@"All the tournament category retrived successfully.");
                    }else{
                        handler(nil,YES,@"Something is wrong, please try agian later.");
                    }
                }
            }
        });
    }];
}

-(void)callGetNearTournamentWithUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:[NSString stringWithFormat:@"user_id=%@",strUserID]];
    
    NSString *postParams = [arr componentsJoinedByString:@"&"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self getTotalURL:allServices[GetNearTournament]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
                NSLog(@"callGetNearTournamentWithUserID Response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//                NSError *error;
//                NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//                if (error) {
//                    handler(error,YES,@"Something is wrong, please try agian later.");
//                }else{
//                    if ([[responseDict objectForKey:@"status"] boolValue]) {
//                        responseDict=[responseDict objectForKey:@"response"];
//                        NSMutableArray *arrTemp=[[responseDict objectForKey:@"category_tournaments"] mutableCopy];
//                        for (int i=0; i<arrTemp.count; i++) {
//                            ModelTournamentCategory *obj=[[ModelTournamentCategory alloc] initWithDictionary:[arrTemp objectAtIndex:i]];
//                            NSLog(@"Object = %@",[arrTemp objectAtIndex:i]);
//                            [arrTemp removeObjectAtIndex:i];
//                            [arrTemp insertObject:obj atIndex:i];
//                        }
//                        handler(arrTemp,NO,@"All the tournament category retrived successfully.");
//                    }else{
//                        handler(nil,YES,@"Something is wrong, please try agian later.");
//                    }
//                }
            }
        });
    }];
}

@end
