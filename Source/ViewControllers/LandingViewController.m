//
//  LandingViewController.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//
#include "AppDelegate.h"
//#import "STTwitter.h"
#import "LandingViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Context.h"
#import "DataClass.h"
#import "StepOneViewController.h"
#import "CustomMapAnnotationView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "CustomLocationManager.h"
#import <TwitterKit/TwitterKit.h>


NSUserDefaults *sharedPref;

@interface LandingViewController ()<CustomLocationManagerDelegate,SingleButtonDelegate>
{
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnTwitter;
    
    UIButton *btnPressed;
    
    TWTRLogInButton *btnBGTwitter;
}
//@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation LandingViewController
@synthesize cpLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    sharedPref = [NSUserDefaults standardUserDefaults];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (IBAction)fbloginClick:(id)sender {
    [sharedPref setInteger:2 forKey:@"LoggedInState"];
    
    
    [self.activityIndicatorView startAnimating];
    [self.view setUserInteractionEnabled:NO];
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        btnPressed=sender;
        [self startLocationManager];
    }else{
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please turn on the location service from the settings" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

- (IBAction)twitterClick:(id)sender {

    if ([CLLocationManager locationServicesEnabled]) {
        btnPressed=sender;
        [self startLocationManager];
    }else{
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please turn on the location service from the settings" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

-(void)didUpdateLocationUpdateWithPlacemark:(CLPlacemark *)placeMark
{
    if (btnPressed==btnFacebook) {
        [self faceBookLoginPressedWithPlaceMark:placeMark];
    }else{
        [self twitterLoginPressedWithPlaceMark:placeMark];
    }
}

-(void)faceBookLoginPressedWithPlaceMark:(CLPlacemark*)placemark
{
    NSDictionary *dict=[self addressDictionaryForPlaceMark:placemark];
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 
                 [[WebService service] callFBLoginServiceWithEmail:[result objectForKey:@"email"] FirstName:[result objectForKey:@"first_name"] LastName:[result objectForKey:@"last_name"] Gender:[result objectForKey:@"gender"] ID:[result objectForKey:@"id"] Link:[result objectForKey:@"link"] Locale:[result objectForKey:@"locale"] Name:[result objectForKey:@"name"] TimeZone:[result objectForKey:@"timezone"] Latitude:[dict objectForKey:@"Latitude"] Longitude:[dict objectForKey:@"Longitude"] Country:[dict objectForKey:@"Country"] State:[dict objectForKey:@"State"] City:[dict objectForKey:@"City"] WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
                     if (isError) {
                         UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
                         UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                             [alertController dismissViewControllerAnimated:YES completion:^{
                                 
                             }];
                         }];
                         [alertController addAction:actionOk];
                         [self presentViewController:alertController animated:YES completion:^{
                             
                         }];
                     }else{
                         if ([result isKindOfClass:[NSDictionary class]]) {
                             NSMutableDictionary *dict=(NSMutableDictionary*)result;
                             
                             id tempUser=[dict objectForKey:@"User"];
                             if ([tempUser isKindOfClass:[ModelUser class]]) {
                                 user=(ModelUser*)tempUser;
                             }
                             id tempAllUser=[dict objectForKey:@"AllUser"];
                             if ([tempAllUser isKindOfClass:[NSMutableArray class]]) {
                                 allUser=(NSMutableArray*)tempAllUser;
                             }
                             stringUserID=user.strID;
                             //[[OnlineOfflineTrackerManager manager] startTrackingUserForUserID:user.strID];
                             [self makeSocketConnectionWithUser:user];
                         }
                     }
                     StepOneViewController *master=[[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
                     [self.navigationController pushViewController:master animated:YES];
                 }];
             }else{
                 UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Facebook login failed" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     [alertController dismissViewControllerAnimated:YES completion:^{
                         
                     }];
                 }];
                 [alertController addAction:actionOk];
                 [self presentViewController:alertController animated:YES completion:^{
                     
                 }];
             }
         }];
    }else{
        [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            NSLog(@"%@",result);
            if (error) {
                // Process error
                NSLog(@"Process Error");
                
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Facebook login failed" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }];
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
                
                
            } else if (result.isCancelled) {
                // Handle cancellations
                NSLog(@"Canceled...");
                
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Login Canceled by the user." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }];
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
                
            } else {
                if ([[result grantedPermissions] containsObject:@"public_profile"]) {
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             NSLog(@"fetched user:%@", result);
                             
                             [[WebService service] callFBLoginServiceWithEmail:[result objectForKey:@"email"] FirstName:[result objectForKey:@"first_name"] LastName:[result objectForKey:@"last_name"] Gender:[result objectForKey:@"gender"] ID:[result objectForKey:@"id"] Link:[result objectForKey:@"link"] Locale:[result objectForKey:@"locale"] Name:[result objectForKey:@"name"] TimeZone:[result objectForKey:@"timezone"] Latitude:[dict objectForKey:@"Latitude"] Longitude:[dict objectForKey:@"Longitude"] Country:[dict objectForKey:@"Country"] State:[dict objectForKey:@"State"] City:[dict objectForKey:@"City"] WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
                                 if (isError) {
                                     
                                 }else{
                                     if ([result isKindOfClass:[NSDictionary class]]) {
                                         NSMutableDictionary *dict=(NSMutableDictionary*)result;
                                         
                                         id tempUser=[dict objectForKey:@"User"];
                                         if ([tempUser isKindOfClass:[ModelUser class]]) {
                                             user=(ModelUser*)tempUser;
                                         }
                                         id tempAllUser=[dict objectForKey:@"AllUser"];
                                         if ([tempAllUser isKindOfClass:[NSMutableArray class]]) {
                                             allUser=(NSMutableArray*)tempAllUser;
                                         }
                                         stringUserID=user.strID;
                                         [self makeSocketConnectionWithUser:user];
                                     }
                                 }
                                 StepOneViewController *master=[[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
                                 [self.navigationController pushViewController:master animated:YES];
                             }];
                         }else{
                             UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Facebook login failed" preferredStyle:UIAlertControllerStyleAlert];
                             UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                 [alertController dismissViewControllerAnimated:YES completion:^{
                                     
                                 }];
                             }];
                             [alertController addAction:actionOk];
                             [self presentViewController:alertController animated:YES completion:^{
                                 
                             }];
                         }
                     }];
                }
                
            }
        }];
    }
}

-(void)twitterLoginPressedWithPlaceMark:(CLPlacemark*)placemark
{
    NSDictionary *dict=[self addressDictionaryForPlaceMark:placemark];
    
    btnBGTwitter = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        // play with Twitter session
        NSLog(@"userID = %@",[session userID]);
        NSLog(@"userName = %@",[session userName]);
        NSLog(@"authToken = %@",[session authToken]);
        NSLog(@"authTokenSecret = %@",[session authTokenSecret]);
        
        [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *twitterUser, NSError *error) {
            NSLog(@"Tweet User Name = %@",twitterUser.name);
            NSLog(@"Tweet User profileImageLargeURL = %@",twitterUser.profileImageLargeURL);
            NSLog(@"Tweet User profileImageMiniURL = %@",twitterUser.profileImageMiniURL);
            NSLog(@"Tweet User profileImageURL = %@",twitterUser.profileImageURL);
            NSLog(@"Tweet User screenName = %@",twitterUser.screenName);
            NSLog(@"Tweet User screenName = %@",twitterUser.userID);
            
            /*
             
             [resultDict setObject:[dict objectForKey:@"City"] forKey:@"City"];
             [resultDict setObject:[dict objectForKey:@"Country"] forKey:@"Country"];
             [resultDict setObject:[dict objectForKey:@"State"] forKey:@"State"];
             [resultDict setObject:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.latitude] forKey:@"Latitude"];
             [resultDict setObject:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.longitude] forKey:@"Longitude"];
             
            */
            
            
            [[WebService service] callTwitterLoginWithUserName:twitterUser.name DisplayName:twitterUser.screenName Email:@"" ProfileImageLargeURL:twitterUser.profileImageLargeURL ProfileImageMini:twitterUser.profileImageMiniURL ProfileImageURL:twitterUser.profileImageURL Country:[dict objectForKey:@"Country"] State:[dict objectForKey:@"State"] City:[dict objectForKey:@"City"] Latitude:[dict objectForKey:@"Latitude"] Longitude:[dict objectForKey:@"Longitude"] TwitterUserID:twitterUser.userID WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
                if (isError) {
                    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [alertController dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                    }];
                    [alertController addAction:actionOk];
                    [self presentViewController:alertController animated:YES completion:^{
                        
                    }];
                }else{
                    
                    if ([result isKindOfClass:[NSDictionary class]]) {
                        NSMutableDictionary *dict=(NSMutableDictionary*)result;
                        
                        id tempUser=[dict objectForKey:@"User"];
                        if ([tempUser isKindOfClass:[ModelUser class]]) {
                            user=(ModelUser*)tempUser;
                        }
                        id tempAllUser=[dict objectForKey:@"AllUser"];
                        if ([tempAllUser isKindOfClass:[NSMutableArray class]]) {
                            allUser=(NSMutableArray*)tempAllUser;
                        }
                        stringUserID=user.strID;
                        //[[OnlineOfflineTrackerManager manager] startTrackingUserForUserID:user.strID];
                        [self makeSocketConnectionWithUser:user];
                        
                        StepOneViewController *master=[[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
                        [self.navigationController pushViewController:master animated:YES];
                    }
                }
            }];
        }];
    }];
    [btnBGTwitter sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)didLocationManagerCompletedWithError:(NSError*)error
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Location service is not available, please turn on the location service and try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

-(IBAction)loginButtonTapped:(id)sender
{
    LoginViewController *lVC  = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:lVC animated:YES];
}
-(IBAction)registerButtonTapped:(id)sender
{
    RegisterViewController *master  = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:master animated:YES];
}


/*-(void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier {
    
    // in case the user has just authenticated through WebViewVC
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        NSLog(@"-- UserID: %@", userID);
        

        [self.twitter getUsersShowForUserID:userID orScreenName:screenName includeEntities:nil successBlock:^(NSDictionary *user) {
            
            NSLog(@"TW User Details =  %@",user);
            NSLog(@"Screen Name =%@ ", screenName);
            
            [sharedPref setValue:screenName forKey:@"UserName"];
            //[sharedPref setValue:eMail forKey:@"EmailId"];
            //[sharedPref setValue:gender forKey:@"Gender"];
            [sharedPref synchronize];
            
            [sharedPref setBool:YES forKey:@"isLogedin"];
            
            StepOneViewController *sVC = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
            [self.navigationController pushViewController:sVC animated:YES];
            
            
        }errorBlock:^(NSError *error) {
            
            //self.fbNameLabel.text = [error localizedDescription];
            NSLog(@"-- %@", [error localizedDescription]);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- %@", [error localizedDescription]);
    }];
    
}*/




@end
