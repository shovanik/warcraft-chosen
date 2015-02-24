//
//  ModelUser.h
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelUser : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strFbID;
@property(strong,nonatomic) NSString *strUserName;
@property(strong,nonatomic) NSString *strEmailID;
@property(strong,nonatomic) NSString *strEmailVerificationKey;
@property(strong,nonatomic) NSString *strFirstName;
@property(strong,nonatomic) NSString *strLastName;
@property(strong,nonatomic) NSString *strGender;
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

-(ModelUser*)initWithDictionary:(NSDictionary*)dictionary;

@end
