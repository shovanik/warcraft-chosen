//
//  ModelUser.h
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"
#import "ModelAvtarImage.h"

@interface ModelUser : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strFbID;
@property(strong,nonatomic) NSString *strUserName;
@property(strong,nonatomic) NSString *strEmailID;
@property(strong,nonatomic) NSString *strEmailVerificationKey;
@property(strong,nonatomic) NSString *strFirstName;
@property(strong,nonatomic) NSString *strLastName;
@property(strong,nonatomic) NSString *strGenderShort;
@property(strong,nonatomic) NSString *strGenderLong;
@property(strong,nonatomic) NSString *strDateOfBirth;
@property(strong,nonatomic) NSString *strCountryName;
@property(strong,nonatomic) NSString *strStateName;
@property(strong,nonatomic) NSString *strCityName;
@property(strong,nonatomic) NSString *strAddress;
@property(strong,nonatomic) NSString *strLatitude;
@property(strong,nonatomic) NSString *strLongitude;
@property(strong,nonatomic) NSString *strStatus;
@property(strong,nonatomic) NSString *strUpdated;
@property(strong,nonatomic) NSString *strCreated;
@property(strong,nonatomic) NSString *strOnline;
@property(strong,nonatomic) ModelAvtarImage *avtarImage;
@property(strong,nonatomic) NSString *strLastSeen;
@property(strong,nonatomic) NSString *strDefaultImageURL;
@property(strong,nonatomic) NSString *strDefaultImage;
@property(assign,nonatomic) BOOL isUseDefaultImage;
@property(strong,nonatomic) NSString *strAge;
@property(strong,nonatomic) NSString *strAvtarImage;
@property(strong,nonatomic) NSString *strLevel;


@property(strong,nonatomic) NSString *strFBId;
@property(strong,nonatomic) NSString *strLink;
@property(strong,nonatomic) NSString *strLocale;
@property(strong,nonatomic) NSString *strName;
@property(strong,nonatomic) NSString *strTimeZone;

-(ModelUser*)initWithDictionary:(NSDictionary*)dictionary BaseURL:(NSString*)strBaseURL;
-(id)initWithUser:(ModelUser*)myUser;

@end
