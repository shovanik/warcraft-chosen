//
//  BaseViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "DeviceConstant.h"
#import "Constants.h"
#import "GlobalVariable.h"

#import "WebService.h"

#import "ModelUser.h"
#import "ModelPrivacyPolicy.h"
#import "ModelTerms.h"
#import "ModelAboutUs.h"
#import "ModelTournamentCategory.h"
#import "ModelTournamentSubCategory.h"

#import "GuildImageView.h"

#import "NSMutableArray+FoundGuild.h"
#import "NSMutableArray+FoundUser.h"
#import "CustomConfirmationViewController.h"

#import "SingleButtonAlertViewController.h"

#import "WebServiceConstant.h"

typedef enum : NSUInteger {
    StartFight=0,
    AcceptFight,
    DeclineFight,
    ReadyToFight,
    ReadyToFightResponse,
    SendHit,
    SocketError,
    OnlineUsers,
    OnlineUsersResponse,
    beginFight,
    endFight,
} SocketEvent;


NSString static *socketEvents[]={
    [StartFight]=@"startFight",
    [AcceptFight]=@"acceptFight",
    [DeclineFight]=@"declineFight",
    [ReadyToFight]=@"readyToFight",
    [ReadyToFightResponse]=@"readyToFightResponse",
    [SendHit]=@"sendHit",
    [SocketError]=@"socketError",
    [OnlineUsers]=@"getOnlineUsers",
    [OnlineUsersResponse]=@"getOnlineUsersResponse",
    [beginFight]=@"beginFight",
    [endFight]=@"endFight",
};



#define __kNetworkUnavailableMessage @"No internet connection is available, please try again later."



@interface BaseViewController : UIViewController

@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@property(assign,nonatomic) BOOL isNetworkRechable;

@property(strong,nonatomic) BaseViewController *myParentViewController;


-(void)startLocationManager;
-(void)stopLocationManager;

-(void)acceptFightPressed;
-(void)declineFightPressed;

-(NSDictionary*)addressDictionaryForPlaceMark:(CLPlacemark *)placeMark;

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

-(void)openSlideMenu;

-(void)closeSlideMenu;

-(IBAction)btnMenuTapped:(id)sender;




-(void)makeSocketConnectionWithUser:(ModelUser*)myUser;

-(void)sendFightRequestToUser:(ModelUser*)userTo;

-(void)sendBeginFight;

-(void)sendReadyToFight;

-(void)sendReadyToFightResponse:(NSString*)strResponse;

-(void)sendHitWithIsHit:(BOOL)isHit HitValue:(NSString *)strHitValue;

-(void)sendGetOnlineUsers;

-(void)sendGetOnlineUsersForTournamentId:(NSString*)strTournamentID;

-(void)disconnectSocket;

@end
