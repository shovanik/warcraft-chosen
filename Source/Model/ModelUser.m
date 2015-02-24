//
//  ModelUser.m
//  Chosen
//
//  Created by Kaustav Shee on 2/18/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelUser.h"

@implementation ModelUser
@synthesize strLongitude;
@synthesize strLatitude;
@synthesize strUserName;
@synthesize strAddress;
@synthesize strCityName;
@synthesize strCountryName;
@synthesize strCreated;
@synthesize strDateOfBirth;
@synthesize strEmailID;
@synthesize strEmailVerificationKey;
@synthesize strFbID;
@synthesize strFirstName;
@synthesize strGender;
@synthesize strID;
@synthesize strLastName;
@synthesize strStateName;
@synthesize strStatus;
@synthesize strUpdated;

-(ModelUser*)initWithDictionary:(NSDictionary*)dictionary
{
    if (self=[super init]) {
        self.strID=[dictionary objectForKey:@"id"];
        self.strFbID=[dictionary objectForKey:@"fb_id"];
        self.strUserName=[dictionary objectForKey:@"user_name"];
        self.strEmailID=[dictionary objectForKey:@"email"];
        self.strEmailVerificationKey=[dictionary objectForKey:@"email_verification_key"];
        self.strFirstName=[dictionary objectForKey:@"first_name"];
        self.strLastName=[dictionary objectForKey:@"last_name"];
        self.strGender=[dictionary objectForKey:@"gender"];
        self.strDateOfBirth=[dictionary objectForKey:@"date_of_birth"];
        self.strCountryName=[dictionary objectForKey:@"country_name"];
        self.strStateName=[dictionary objectForKey:@"state_name"];
        self.strCityName=[dictionary objectForKey:@"city_name"];
        self.strAddress=[dictionary objectForKey:@"address"];
        self.strLatitude=[dictionary objectForKey:@"lat"];
        self.strLongitude=[dictionary objectForKey:@"lon"];
        self.strStatus=[dictionary objectForKey:@"status"];
        self.strUpdated=[dictionary objectForKey:@"updated"];
        self.strCreated=[dictionary objectForKey:@"created"];
    }
    return self;
}

@end
