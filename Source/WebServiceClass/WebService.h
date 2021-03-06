//
//  LoginService.h
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WebServiceBaseClass.h"


@interface WebService : WebServiceBaseClass


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
-(void)callResetPasswordServiceForUserID:(NSString*)strUserID NewPassword:(NSString*)strNewPassword OldPassword:(NSString*)strOldPassword WithCompletionHandler:(CompletionHandler)handler;
//-(void)callLastSeenServiceForUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler;
//-(void)callNearByUserServiceForUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler;
-(void)callAboutUsServiceWithCompletionHandler:(CompletionHandler)handler;
-(void)callPrivacyPolicyWithCompletionHandler:(CompletionHandler)handler;
-(void)callTermsAndConditionWithCompletionHandler:(CompletionHandler)handler;
-(void)callForgetPasswordServiceForEmailID:(NSString*)strEmailID withCompletionHandler:(CompletionHandler)handler;
-(void)callGetAllGuildWithCompletionHandler:(CompletionHandler)handler;
-(void)callGetGuildForGuildID:(NSString*)strGuildID WithCompletionHandler:(CompletionHandler)handler;
-(void)callGetGuildsForUserId:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler;
-(void)callAddGuildForGuildID:(NSString*)strGuildID UserID:(NSString*)strUserID CompletionHandler:(CompletionHandler)handler;
-(void)callGetTournamentCategoryWithCompletionHandler:(CompletionHandler)handler;
-(void)callGetNearTournamentWithUserID:(NSString*)strUserID CategoryID:(NSString*)strCategoryID WithCompletionHandler:(CompletionHandler)handler;

-(void)callFBLoginServiceWithEmail:(NSString*)strEmail FirstName:(NSString*)strFirstName LastName:(NSString*)strLastName Gender:(NSString*)strGender ID:(NSString*)strID Link:(NSString*)strLink Locale:(NSString*)strLocale Name:(NSString*)strName TimeZone:(NSString*)strTimeZone Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude Country:(NSString*)strCountry State:(NSString*)strState City:(NSString*)strCity WithCompletionHandler:(CompletionHandler)handler;

-(void)callTwitterLoginWithUserName:(NSString*)strUserName DisplayName:(NSString*)strDisplayName Email:(NSString*)strEmail ProfileImageLargeURL:(NSString*)strProfileImageLargeURL ProfileImageMini:(NSString*)strProfileImageMiniURL ProfileImageURL:(NSString*)strProfileImageURL Country:(NSString*)strCountry State:(NSString*)strState City:(NSString*)strCity Latitude:(NSString*)strLatitude Longitude:(NSString*)strLongitude TwitterUserID:(NSString*)strTwitterUserId WithCompletionHandler:(CompletionHandler)handler;

//-(void)callStatusChangeToOnlineWithUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler;

//-(void)callStatusChangeToOfflineWithUserID:(NSString*)strUserID WithCompletionHandler:(CompletionHandler)handler;

-(void)callCreateTournamentForCategoryId:(NSString*)strCategoryID Title:(NSString*)strTitle NoOfPlayer:(NSString*)strNoOfPlayer GoldRequired:(NSString*)strGoldRequired Playtime:(NSString*)strPlaytime Radious:(NSString*)strRadious UserID:(NSString*)strUserID Private:(NSString*)strPrivate WithCompletionHandler:(CompletionHandler)handler;

@end
