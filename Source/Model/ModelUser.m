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
@synthesize strGenderShort;
@synthesize strID;
@synthesize strLastName;
@synthesize strStateName;
@synthesize strStatus;
@synthesize strUpdated;
@synthesize strOnline;
@synthesize strAge;
@synthesize strGenderLong;
@synthesize strDefaultImage;
@synthesize strDefaultImageURL;
@synthesize strLastSeen;

-(ModelUser*)initWithDictionary:(NSDictionary*)dictionary BaseURL:(NSString*)strBaseURL
{
    if (self=[super init]) {
        if ([dictionary objectForKey:@"id"]&&!([[dictionary objectForKey:@"id"] isKindOfClass:[[NSNull null] class]])) {
            if ([[dictionary objectForKey:@"id"] isKindOfClass:[NSString class]]) {
                self.strID=[[dictionary objectForKey:@"id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else{
                self.strID=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"id"] integerValue]];
            }
        }else{
            self.strID=@"";
        }
        
        if ([dictionary objectForKey:@"fb_id"]&&!([[dictionary objectForKey:@"fb_id"] isKindOfClass:[[NSNull null] class]])) {
            self.strFbID=[[dictionary objectForKey:@"fb_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strFbID=@"";
        }
        
        if ([dictionary objectForKey:@"user_name"]&&!([[dictionary objectForKey:@"user_name"] isKindOfClass:[[NSNull null] class]])) {
            self.strUserName=[[dictionary objectForKey:@"user_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strUserName=@"";
        }
        
        if ([dictionary objectForKey:@"email"]&&!([[dictionary objectForKey:@"email"] isKindOfClass:[[NSNull null] class]])) {
            self.strEmailID=[[dictionary objectForKey:@"email"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strEmailID=@"";
        }

        if ([dictionary objectForKey:@"email_verification_key"]&&!([[dictionary objectForKey:@"email_verification_key"] isKindOfClass:[[NSNull null] class]])) {
            self.strEmailVerificationKey=[[dictionary objectForKey:@"email_verification_key"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strEmailVerificationKey=@"";
        }
        
        if ([dictionary objectForKey:@"first_name"]&&!([[dictionary objectForKey:@"first_name"] isKindOfClass:[[NSNull null] class]])) {
            self.strFirstName=[[dictionary objectForKey:@"first_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strFirstName=@"";
        }
        
        if ([dictionary objectForKey:@"last_name"]&&!([[dictionary objectForKey:@"last_name"] isKindOfClass:[[NSNull null] class]])) {
            self.strLastName=[[dictionary objectForKey:@"last_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strLastName=@"";
        }
        
        if ([dictionary objectForKey:@"gender"]&&!([[dictionary objectForKey:@"gender"] isKindOfClass:[[NSNull null] class]])) {
            self.strGenderShort=[[dictionary objectForKey:@"gender"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strGenderShort=@"";
        }
        
        if ([strGenderShort stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
            if ([[[strGenderShort stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString] isEqualToString:@"M"]) {
                self.strGenderLong=@"Male";
            }else{
                self.strGenderLong=@"Female";
            }
        }else{
            self.strGenderLong=@"";
        }
        
        

        if ([dictionary objectForKey:@"date_of_birth"]&&!([[dictionary objectForKey:@"date_of_birth"] isKindOfClass:[[NSNull null] class]])) {
            if ([[dictionary objectForKey:@"date_of_birth"] isKindOfClass:[NSString class]]) {
                self.strDateOfBirth=[[dictionary objectForKey:@"date_of_birth"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else{
                if (!dateFormattter) {
                    dateFormattter=[[NSDateFormatter alloc] init];
                    [dateFormattter setTimeZone:[NSTimeZone systemTimeZone]];
                }
                NSDate *myDate=[NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:@"date_of_birth"] longLongValue]];
                [dateFormattter setDateFormat:@"yyyy-MM-dd"];
                self.strDateOfBirth=[dateFormattter stringFromDate:myDate];
            }
        }else{
            self.strDateOfBirth=@"";
        }
        
        if ([dictionary objectForKey:@"country_name"]&&!([[dictionary objectForKey:@"country_name"] isKindOfClass:[[NSNull null] class]])) {
            self.strCountryName=[[dictionary objectForKey:@"country_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strCountryName=@"";
        }
        
        if ([dictionary objectForKey:@"state_name"]&&!([[dictionary objectForKey:@"state_name"] isKindOfClass:[[NSNull null] class]])) {
            self.strStateName=[[dictionary objectForKey:@"state_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strStateName=@"";
        }
        
        if ([dictionary objectForKey:@"city_name"]&&!([[dictionary objectForKey:@"city_name"] isKindOfClass:[[NSNull null] class]])) {
            self.strCityName=[[dictionary objectForKey:@"city_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strCityName=@"";
        }
        
        if ([dictionary objectForKey:@"address"]&&!([[dictionary objectForKey:@"address"] isKindOfClass:[[NSNull null] class]])) {
            self.strAddress=[[dictionary objectForKey:@"address"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strAddress=@"";
        }
        
        if ([dictionary objectForKey:@"lat"]&&!([[dictionary objectForKey:@"lat"] isKindOfClass:[[NSNull null] class]])) {
            self.strLatitude=[[dictionary objectForKey:@"lat"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strLatitude=@"";
        }
        
        if ([dictionary objectForKey:@"lon"]&&!([[dictionary objectForKey:@"lon"] isKindOfClass:[[NSNull null] class]])) {
            self.strLongitude=[[dictionary objectForKey:@"lon"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strLongitude=@"";
        }
        
        if ([dictionary objectForKey:@"status"]&&!([[dictionary objectForKey:@"status"] isKindOfClass:[[NSNull null] class]])) {
            self.strStatus=[[dictionary objectForKey:@"status"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strStatus=@"";
        }
        
        if ([dictionary objectForKey:@"updated"]&&!([[dictionary objectForKey:@"updated"] isKindOfClass:[[NSNull null] class]])) {
            self.strUpdated=[[dictionary objectForKey:@"updated"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strUpdated=@"";
        }
        
        if ([dictionary objectForKey:@"created"]&&!([[dictionary objectForKey:@"created"] isKindOfClass:[[NSNull null] class]])) {
            self.strCreated=[[dictionary objectForKey:@"created"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strCreated=@"";
        }
        
        if ([dictionary objectForKey:@"online"]&&!([[dictionary objectForKey:@"online"] isKindOfClass:[[NSNull null] class]])) {
            if ([[dictionary objectForKey:@"online"] isKindOfClass:[NSString class]]) {
                self.strOnline=[[dictionary objectForKey:@"online"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else{
                self.strOnline=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"online"] integerValue]];
            }
            
        }else{
            self.strOnline=@"";
        }
        
        
        if ([dictionary objectForKey:@"image"]&&!([[dictionary objectForKey:@"image"] isKindOfClass:[[NSNull null] class]])) {
            self.avtarImage=[[ModelAvtarImage alloc] initWithDictionary:[dictionary objectForKey:@"image"] BaseURL:strBaseURL];
        }else{
            self.avtarImage=nil;
        }
        
        if ([dictionary objectForKey:@"last_seen"]&&!([[dictionary objectForKey:@"last_seen"] isKindOfClass:[[NSNull null] class]])) {
            self.strLastSeen=[[dictionary objectForKey:@"last_seen"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strLastSeen=@"";
        }
        
        if ([dictionary objectForKey:@"default_image_picture"]&&!([[dictionary objectForKey:@"default_image_picture"] isKindOfClass:[[NSNull null] class]])) {
            self.strDefaultImageURL=[NSString stringWithFormat:@"%@%@",strBaseURL,[[dictionary objectForKey:@"default_image_picture"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }else{
            self.strDefaultImageURL=@"";
        }
        
        if ([dictionary objectForKey:@"default_image"]&&!([[dictionary objectForKey:@"default_image"] isKindOfClass:[[NSNull null] class]])) {
            if ([[dictionary objectForKey:@"default_image"] isKindOfClass:[NSString class]]) {
                self.strDefaultImage=[[dictionary objectForKey:@"default_image"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else{
                self.strDefaultImage=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"default_image"] integerValue]];
            }
            
        }else{
            self.strDefaultImage=@"";
        }
        
        if ([self.strDefaultImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
            if ([[self.strDefaultImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"1"]) {
                self.isUseDefaultImage=YES;
            }
            else if ([[self.strDefaultImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"0"]){
                self.isUseDefaultImage=NO;
            }
        }else{
            self.isUseDefaultImage=YES;
        }
        
        if ([dictionary objectForKey:@"avatar_image"]&&!([[dictionary objectForKey:@"avatar_image"] isKindOfClass:[[NSNull null] class]])) {
            self.strAvtarImage=[[dictionary objectForKey:@"avatar_image"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strAvtarImage=@"";
        }
        
        if ([dictionary objectForKey:@"level"]&&!([[dictionary objectForKey:@"level"] isKindOfClass:[[NSNull null] class]])) {
            if ([[dictionary objectForKey:@"level"] isKindOfClass:[NSString class]]) {
                self.strLevel=[[dictionary objectForKey:@"level"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else{
                self.strLevel=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"level"] integerValue]];
            }
            
        }else{
            self.strLevel=@"0";
        }
        
        if ([dictionary objectForKey:@"fb_id"]&&!([[dictionary objectForKey:@"fb_id"] isKindOfClass:[[NSNull null] class]])) {
            self.strFBId=[[dictionary objectForKey:@"fb_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strFBId=@"";
        }

        if ([dictionary objectForKey:@"link"]&&!([[dictionary objectForKey:@"link"] isKindOfClass:[[NSNull null] class]])) {
            self.strLink=[[dictionary objectForKey:@"link"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strLink=@"";
        }

        if ([dictionary objectForKey:@"locale"]&&!([[dictionary objectForKey:@"locale"] isKindOfClass:[[NSNull null] class]])) {
            self.strLocale=[[dictionary objectForKey:@"locale"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strLocale=@"";
        }
        
        if ([dictionary objectForKey:@"name"]&&!([[dictionary objectForKey:@"name"] isKindOfClass:[[NSNull null] class]])) {
            self.strName=[[dictionary objectForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strName=@"";
        }
        
        if ([dictionary objectForKey:@"timeZone"]&&!([[dictionary objectForKey:@"timeZone"] isKindOfClass:[[NSNull null] class]])) {
            self.strTimeZone=[[dictionary objectForKey:@"timeZone"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strTimeZone=@"";
        }
    }
    
    if ([strDateOfBirth stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
        NSDate *earlier=[dateFormattter dateFromString:strDateOfBirth];
        NSDate *today=[NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        // pass as many or as little units as you like here, separated by pipes
        NSUInteger units = /*NSCalendarUnitDay | NSCalendarUnitMonth |*/ NSCalendarUnitYear;
        
        NSDateComponents *components = [gregorian components:units fromDate:earlier toDate:today options:0];
        
        NSInteger years = [components year];
        self.strAge=[NSString stringWithFormat:@"%ld",(long)years];
    }else{
        self.strAge=@"0";
    }
    
    if ([dictionary objectForKey:@"xp"]&&!([[dictionary objectForKey:@"xp"] isKindOfClass:[[NSNull null] class]])) {
        if ([[dictionary objectForKey:@"xp"] isKindOfClass:[NSString class]]) {
            self.strXP=[[dictionary objectForKey:@"xp"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strXP=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"xp"] integerValue]];
        }
        
    }else{
        self.strXP=@"0";
    }
    
    if ([dictionary objectForKey:@"total_wins"]&&!([[dictionary objectForKey:@"total_wins"] isKindOfClass:[[NSNull null] class]])) {
        if ([[dictionary objectForKey:@"total_wins"] isKindOfClass:[NSString class]]) {
            self.strTotalWins=[[dictionary objectForKey:@"total_wins"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strTotalWins=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"total_wins"] integerValue]];
        }
        
    }else{
        self.strTotalWins=@"0";
    }
    
    if ([dictionary objectForKey:@"total_loss"]&&!([[dictionary objectForKey:@"total_loss"] isKindOfClass:[[NSNull null] class]])) {
        if ([[dictionary objectForKey:@"total_loss"] isKindOfClass:[NSString class]]) {
            self.strTotalLoss=[[dictionary objectForKey:@"total_loss"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strTotalLoss=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"total_loss"] integerValue]];
        }
    }else{
        self.strTotalLoss=@"0";
    }
    
    if ([dictionary objectForKey:@"status_points"]&&!([[dictionary objectForKey:@"status_points"] isKindOfClass:[[NSNull null] class]])) {
        if ([[dictionary objectForKey:@"status_points"] isKindOfClass:[NSString class]]) {
            self.strStatusPoint=[[dictionary objectForKey:@"status_points"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strStatusPoint=[NSString stringWithFormat:@"%ld",(long)[[dictionary objectForKey:@"status_points"] integerValue]];
        }
    }else{
        self.strStatusPoint=@"0";
    }
    
    if ([dictionary objectForKey:@"last_game_finished"]&&!([[dictionary objectForKey:@"last_game_finished"] isKindOfClass:[[NSNull null] class]])) {
        if ([[dictionary objectForKey:@"last_game_finished"] isKindOfClass:[NSString class]]) {
            self.strLastGameFinisehd=[[dictionary objectForKey:@"last_game_finished"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }else{
            self.strDateOfBirth=[NSString stringWithFormat:@"%lld",[[dictionary objectForKey:@"last_game_finished"] longLongValue]];
        }
    }else{
        self.strDateOfBirth=@"";
    }
    
    if ([dictionary objectForKey:@"avatar_thumb"]&&!([[dictionary objectForKey:@"avatar_thumb"] isKindOfClass:[[NSNull null] class]])) {
        self.strAvtarThumbImg=[[dictionary objectForKey:@"avatar_thumb"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }else{
        self.strAvtarThumbImg=@"";
    }
    
    return self;
}

-(id)initWithUser:(ModelUser*)myUser
{
    if (self=[super init]) {
        self.strAddress=[NSString stringWithString:myUser.strAddress];
        self.strAge=[NSString stringWithString:myUser.strAge];
        self.strAvtarImage=[NSString stringWithString:myUser.strAvtarImage];
        self.strCityName=[NSString stringWithString:myUser.strCityName];
        self.strCountryName=[NSString stringWithString:myUser.strCountryName];
        self.strCreated=[NSString stringWithString:myUser.strCreated];
        self.strDateOfBirth=[NSString stringWithString:myUser.strDateOfBirth];
        self.strDefaultImage=[NSString stringWithString:myUser.strDefaultImage];
        self.strDefaultImageURL=[NSString stringWithString:myUser.strDefaultImageURL];
        self.strEmailID=[NSString stringWithString:myUser.strEmailID];
        self.strEmailVerificationKey=[NSString stringWithString:myUser.strEmailVerificationKey];
        self.strFbID=[NSString stringWithString:myUser.strFbID];
        self.strFirstName=[NSString stringWithString:myUser.strFirstName];
        self.strGenderLong=[NSString stringWithString:myUser.strGenderLong];
        self.strGenderShort=[NSString stringWithString:myUser.strGenderShort];
        self.strID=[NSString stringWithString:myUser.strID];
        self.strLastName=[NSString stringWithString:myUser.strLastName];
        self.strLastSeen=[NSString stringWithString:myUser.strLastSeen];
        self.strLatitude=[NSString stringWithString:myUser.strLatitude];
        self.strLevel=[NSString stringWithString:myUser.strLevel];
        self.strLongitude=[NSString stringWithString:myUser.strLongitude];
        self.strOnline=[NSString stringWithString:myUser.strOnline];
        self.strStateName=[NSString stringWithString:myUser.strStateName];
        self.strStatus=[NSString stringWithString:myUser.strStatus];
        self.strUpdated=[NSString stringWithString:myUser.strUpdated];
        self.strUserName=[NSString stringWithString:myUser.strUserName];
        self.strXP=[NSString stringWithString:myUser.strXP];
        self.strTotalWins=[NSString stringWithString:myUser.strTotalWins];
        self.strTotalLoss=[NSString stringWithString:myUser.strTotalLoss];
        self.strStatusPoint=[NSString stringWithString:myUser.strStatusPoint];
    }
    return self;
}

@end
