//
//  BaseViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 2/19/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

#include<unistd.h>
#include<netdb.h>

#import "CustomLocationManager.h"
#import "SlideOutMenuViewController.h"

#import "WorldMapViewController.h"

#import "WebServiceConstant.h"
#import "SocketService.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "AttackViewController.h"
#import "WorldMapViewController.h"

@import AVKit;

@interface BaseViewController ()<CustomLocationManagerDelegate,SlideOutMenuDelegate,SocketIODelegate>
{
    CustomLocationManager *locationManager;
    SocketService *socketService;
    
    
    NSString *strSocketFromUID;
    NSString *strSocketToUID;
    
    BOOL isReadyToFightReceived;
}

@property(strong) Reachability * googleReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;


@end

@implementation BaseViewController

#pragma mark
#pragma mark Initialization Methods
#pragma mark

-(id)init
{
    if (self=[super init]) {
        self.myParentViewController=self;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        self.myParentViewController=self;
    }
    return self;
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.myParentViewController=self;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark
#pragma mark DateFormat String Initialization
#pragma mark
    strDateFormat=@"yyyy-MM-dd";
#pragma mark
#pragma mark DateFormatter Initialization
#pragma mark
    dateFormattter=[[NSDateFormatter alloc] init];
    [dateFormattter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormattter setDateFormat:strDateFormat];
#pragma mark
#pragma mark Activity Indicator Initialization
#pragma mark
    
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
#pragma mark
#pragma mark Side Panel Initialization
#pragma mark
    
    slideMenu.delegate=self;
    _isSlidemenuOpen=NO;
    
#pragma mark
#pragma mark Location Manager Initialization
#pragma mark
    
    locationManager=[[CustomLocationManager alloc] init];
    locationManager.delegate=self;
    
#pragma mark
#pragma mark Rechability Initialization
#pragma mark
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

    __weak __block typeof(self)weakself=self;
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a Reachability object for www.google.com
    
    self.googleReach = [Reachability reachabilityWithHostname:__kHostName];
    
    self.googleReach.reachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Rechable", __kHostName]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            weakself.isNetworkRechable=YES;
        }];
    };
    
    self.googleReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Rechable", __kHostName]);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=NO;
        });
    };
    
    [self.googleReach startNotifier];
    
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a reachability for the local WiFi
    
    self.localWiFiReach = [Reachability reachabilityForLocalWiFi];
    
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    self.localWiFiReach.reachableOnWWAN = NO;
    
    self.localWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Rechable", __kHostName]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=YES;
        });
    };
    
    self.localWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Rechable", __kHostName]);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=NO;
        });
    };
    
    [self.localWiFiReach startNotifier];
    
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a Reachability object for the internet
    
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    
    self.internetConnectionReach.reachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Rechable", __kHostName]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=YES;
        });
    };
    
    self.internetConnectionReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Rechable", __kHostName]);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworkRechable=NO;
        });
    };
    
    [self.internetConnectionReach startNotifier];
    
    
#pragma mark
#pragma mark Shadow Set
#pragma mark
    
    CALayer *layer = self.navigationController.view.layer;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor darkTextColor] CGColor];
    layer.shadowRadius = 10.0f;
    layer.shadowOpacity = 1.0f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark
#pragma mark Common IBAction
#pragma mark

-(IBAction)btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnMenuTapped:(id)sender
{
    if (self.isSlidemenuOpen) {
        [self closeSlideMenu];
    }else{
        [self openSlideMenu];
    }
}

#pragma mark
#pragma mark Location Manager Helping Methods
#pragma mark

-(void)startLocationManager
{
    [locationManager startLocationManager];
}
-(void)stopLocationManager
{
    [locationManager stopLocationManager];
}

-(NSDictionary*)addressDictionaryForPlaceMark:(CLPlacemark*)placeMark
{
    NSDictionary *dict=placeMark.addressDictionary;
    NSMutableDictionary *resultDict=[[NSMutableDictionary alloc] init];
    [resultDict setObject:[dict objectForKey:@"City"] forKey:@"City"];
    [resultDict setObject:[dict objectForKey:@"Country"] forKey:@"Country"];
    [resultDict setObject:[dict objectForKey:@"State"] forKey:@"State"];
    [resultDict setObject:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.latitude] forKey:@"Latitude"];
    [resultDict setObject:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.longitude] forKey:@"Longitude"];
    return [NSDictionary dictionaryWithDictionary:resultDict];
}

#pragma mark
#pragma mark Custom Location Manager Delegate Methods
#pragma mark

-(void)didLocationManagerCompletedWithError:(NSError *)error
{
    NSLog(@"Error = %@",[error description]);
}

-(void)didUpdateLocationUpdateWithPlacemark:(CLPlacemark *)placeMark
{
    NSLog(@"%@",[self addressDictionaryForPlaceMark:placeMark]);
}

#pragma mark
#pragma mark Email Validation
#pragma mark

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
#pragma mark
#pragma mark Slide Menu Helping method
#pragma mark

-(void)openSlideMenu
{
    if (!_isSlidemenuOpen) {
        UIWindow *window=[[UIApplication sharedApplication] keyWindow];
        [UIView animateWithDuration:0.5 animations:^{
            window.rootViewController.view.frame=CGRectMake(window.frame.size.width-50, 0, window.frame.size.width, window.frame.size.height);
        } completion:^(BOOL finished) {
            _isSlidemenuOpen=YES;
        }];
    }
}
-(void)closeSlideMenu
{
    if (_isSlidemenuOpen) {
        UIWindow *window=[[UIApplication sharedApplication] keyWindow];
        [UIView animateWithDuration:0.5 animations:^{
            window.rootViewController.view.frame=CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
        } completion:^(BOOL finished) {
            _isSlidemenuOpen=NO;
        }];
    }
}



#pragma mark
#pragma mark Slide Menu Delegate
#pragma mark

-(void)didWorlMapClicked
{
    NSLog(@"didWorlMapClicked");
    [self closeSlideMenu];
}
-(void)didGuildClicked
{
    NSLog(@"didGuildClicked");
    [self closeSlideMenu];
}

-(void)didContractClicked
{
    NSLog(@"didContractClicked");
    [self closeSlideMenu];
}
-(void)didTournamentClicked
{
    NSLog(@"didTournamentClicked");
    [self closeSlideMenu];
}
-(void)didSettingsClicked
{
    NSLog(@"didSettingsClicked");
    [self closeSlideMenu];
}

-(void)didLogoutTapped
{
    NSLog(@"didLogoutTapped");
    [self closeSlideMenu];
}

#pragma mark
#pragma mark Slide Menu Delegate
#pragma mark

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if(reach == self.googleReach)
    {
        if([reach isReachable])
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Reachable", __kHostName]);
            self.isNetworkRechable=YES;
        }
        else
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Reachable", __kHostName]);
            self.isNetworkRechable=NO;
        }
    }
    else if (reach == self.localWiFiReach)
    {
        if([reach isReachable])
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Reachable", __kHostName]);
            self.isNetworkRechable=YES;
        }
        else
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Reachable", __kHostName]);
            self.isNetworkRechable=NO;
        }
    }
    else if (reach == self.internetConnectionReach)
    {
        if([reach isReachable])
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Reachable", __kHostName]);
            self.isNetworkRechable=YES;
        }
        else
        {
            NSLog(@"%@", [NSString stringWithFormat:@"%@ Not Reachable", __kHostName]);
            self.isNetworkRechable=NO;
        }
    }
}

#pragma mark
#pragma mark SocketConnection Helper Method
#pragma mark

-(void)makeSocketConnectionWithUser:(ModelUser*)myUser
{
    [[SocketService service] makeSocketConnectionWithUser:myUser Delegate:self];
    userRival=[[ModelUser alloc] initWithUser:myUser];
}

-(void)sendFightRequestToUser:(ModelUser*)userTo
{
    NSLog(@"sendFightRequest");
    [mySocket sendEvent:socketEvents[StartFight] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userTo.strID,@"sendFightRequest"] forKeys:@[@"uid",@"fid",@"meta"]]];
}
-(void)sendBeginFight
{
    NSLog(@"sendFightRequest");
    [mySocket sendEvent:socketEvents[beginFight] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID] forKeys:@[@"uid",@"fid"]]];
}

-(void)acceptFightPressed
{
    NSLog(@"acceptFightPressed");
    [mySocket sendEvent:socketEvents[AcceptFight] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID,socketEvents[AcceptFight]] forKeys:@[@"uid",@"fid",@"meta"]]];
    AttackViewController *master=[[AttackViewController alloc] initWithNibName:@"AttackViewController" bundle:nil];
    [[SocketService service] makeSocketDelegate:nil];
    [[SocketService service] makeSocketDelegate:master];
    master.isStartFightReceived=YES;
    [self.navigationController pushViewController:master animated:YES];
}

-(void)declineFightPressed
{
    NSLog(@"declineFightPressed");
    [mySocket sendEvent:socketEvents[DeclineFight] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID,socketEvents[DeclineFight]] forKeys:@[@"uid",@"fid",@"meta"]]];
}

-(void)sendReadyToFight
{
    [mySocket sendEvent:socketEvents[ReadyToFight] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID,socketEvents[ReadyToFight]] forKeys:@[@"uid",@"fid",@"meta"]]];
}

-(void)sendReadyToFightResponse:(NSString *)strResponse
{
    [mySocket sendEvent:socketEvents[ReadyToFightResponse] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID,strResponse] forKeys:@[@"uid",@"fid",@"meta"]]];
}

-(void)sendHitWithStatus:(NSString*)strStatus Distance:(NSString*)strDistance
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjects:@[strStatus,strDistance] forKeys:@[@"Status",@"Distance"]];
    [mySocket sendEvent:socketEvents[SendHit] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID,dict] forKeys:@[@"uid",@"fid",@"meta"]]];
}

-(void)sendHitWithIsHit:(BOOL)isHit HitValue:(NSString *)strHitValue
{
    NSDictionary *dict;
    if (isHit) {
        dict=[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"1"],strHitValue] forKeys:@[@"hit",@"hitValue"]];
    }else{
        dict=[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"0"],strHitValue] forKeys:@[@"hit",@"hitValue"]];
    }
    [mySocket sendEvent:socketEvents[SendHit] withData:[NSDictionary dictionaryWithObjects:@[user.strID,userRival.strID,dict] forKeys:@[@"uid",@"fid",@"meta"]]];
}

-(void)sendGetOnlineUsers
{
    //[mySocket sendEvent:socketEvents[OnlineUsers] withData:nil forKeys:nil]];
    [mySocket sendEvent:socketEvents[OnlineUsers] withData:nil];
}


#pragma mark
# pragma mark socket.IO-objc delegate methods
#pragma mark

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
    mySocket=socket;
}
- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    //NSLog(@"didReceiveEvent()");
    
    
    if ([self.navigationController.topViewController isKindOfClass:[AttackViewController class]]) {
        AttackViewController *master=(AttackViewController*)self.navigationController.topViewController;
        [master socketIO:socket didReceiveEvent:packet];
    }
    else if ([self.navigationController.topViewController isKindOfClass:[WorldMapViewController class]]){
        WorldMapViewController *master=(WorldMapViewController*)self.navigationController.topViewController;
        [master socketIO:socket didReceiveEvent:packet];
    }
    else{
        NSLog(@"%@",packet.data);
        NSLog(@"%@",packet.dataAsJSON);
        
        NSError *error;
        NSDictionary *dict=packet.dataAsJSON;
        
        if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[StartFight]]) {
            NSLog(@"This is start Fight.");
            
            NSDictionary *dict=packet.dataAsJSON;
            NSArray *arrTemp=[dict objectForKey:@"args"];
            dict=arrTemp[0];
            userRival=[allUser getUserForUserID:[dict objectForKey:@"uid"]];
            
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Fight Request" message:@"You have received a fight request, please confirm whether you want to fight or not." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionStartFight=[UIAlertAction actionWithTitle:@"Start Fight" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [self acceptFightPressed];
            }];
            UIAlertAction *actionDeclineFight=[UIAlertAction actionWithTitle:@"Decline Fight" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [self declineFightPressed];
            }];
            [alertController addAction:actionStartFight];
            [alertController addAction:actionDeclineFight];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
        else if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[AcceptFight]]) {
            NSLog(@"This is AcceptFight.");
            
            NSDictionary *dict=packet.dataAsJSON;
            NSArray *arrTemp=[dict objectForKey:@"args"];
            dict=arrTemp[0];
            userRival=[allUser getUserForUserID:[dict objectForKey:@"uid"]];
            AttackViewController *master=[[AttackViewController alloc] initWithNibName:@"AttackViewController" bundle:nil];
            [[SocketService service] makeSocketDelegate:nil];
            [[SocketService service] makeSocketDelegate:master];
            [self.navigationController pushViewController:master animated:YES];
        }
        else if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[DeclineFight]]) {
            NSLog(@"This is DeclineFight.");
        }
        else if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[SocketError]]) {
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry you have send the game play request to an offline user." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
        
        if (error) {
            [socket disconnectForced];
        }else{
            NSLog(@"%@",dict);
        }
    }
    
    
    
    
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    if ([error code] == SocketIOUnauthorized) {
        NSLog(@"not authorized");
    } else {
        NSLog(@"onError() %@", error);
    }
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
}

-(void)disconnectSocket
{
    [[SocketService service] disConnectSocket];
}

@end
