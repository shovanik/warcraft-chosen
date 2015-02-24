//
//  LoginService.h
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WebServiceBaseClass.h"


#import "ModelUser.h"



@interface WebService : WebServiceBaseClass
{
    @private
    NSString *strLoginURL;
    NSString *strRegistrationURL;
    NSString *strUpdateURL;
}

#pragma mark
#pragma mark WebService Shared Instance
#pragma mark

+(WebService*)service;

#pragma mark
#pragma mark Login Service
#pragma mark

-(void)callLoginServiceWithUserName:(NSString*)strUserName Password:(NSString*)strPassword Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude WithCompletionHandler:(CompletionHandler)handler;

-(void)callRegistrationServiceWithUserName:(NSString*)strUserName Password:(NSString*)strPassword DateOfBirth:(NSString*)strDateOfBirth Email:(NSString*)strEmail Gender:(NSString*)strGender StateName:(NSString*)strStateName CountryName:(NSString*)strCountrName CityName:(NSString*)strCityName Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude WithCompletionHandler:(CompletionHandler)handler;

-(void)callUpdateUserserviceWithUserName:(NSString*)strUserName UserID:(NSString*)strUserID DateOfBirth:(NSString*)strDateOfBirth Email:(NSString*)strEmail Gender:(NSString*)strGender StateName:(NSString*)strStateName CountryName:(NSString*)strCountrName CityName:(NSString*)strCityName Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude WithCompletionHandler:(CompletionHandler)handler;

@end
