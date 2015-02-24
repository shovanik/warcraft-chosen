//
//  LandingViewController.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//
#import <FacebookSDK/FacebookSDK.h>
#include "AppDelegate.h"
#import "STTwitter.h"
#import "LandingViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Context.h"
#import "DataClass.h"
#import "StepOneViewController.h"
NSUserDefaults *sharedPref;

@interface LandingViewController ()
@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation LandingViewController
@synthesize cpLabel;
FBLoginView *fbLoginView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
    //Print all font name
  /*  for(NSString *family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        for(NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    } 
   */
    
    //self.cpLabel.font = [UIFont fontWithName:@"Garamond" size:17];
    sharedPref = [NSUserDefaults standardUserDefaults];

    
    
    fbLoginView=[[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]];
    fbLoginView.delegate = self;
    fbLoginView.frame = CGRectMake(1, 1, 0, 0);
    
    for (id obj in fbLoginView.subviews)
    {
        
        if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel * loginLabel =  obj;
            loginLabel.frame = CGRectMake(1, 1, 0, 0);
        }
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton * loginButton =  obj;
            UIImage *loginImage = [UIImage imageNamed:@"fblogin.png"];
            [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
            [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
            [loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            [loginButton sizeToFit];
        }
        
        
    }
    
    fbLoginView.hidden=YES;
    [self.view addSubview:fbLoginView];
    
}

//- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
//{
//    StepOneViewController *sVC  = nil;
//    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
//        //For Iphone4
//        sVC = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController_iPhone4" bundle:nil];
//        // NSLog(@"iPhone4");
//    }else{
//        sVC =  [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];;
//        
//        //  NSLog(@"iPhone6");
//        
//    }
//    [self.navigationController pushViewController:sVC animated:YES];
//}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    
    for (id obj in fbLoginView.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        {

            UIButton * loginButton =  obj;
            UIImage *loginImage = [UIImage imageNamed:@"fblogout.png"];
            [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
            [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
            [loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            [loginButton sizeToFit];
        }
        
        if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel * loginLabel =  obj;
            loginLabel.text = @"Log out from Facebook";
            loginLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16.0];
            loginLabel.textAlignment = NSTextAlignmentCenter;
            //loginLabel.textAlignment = NSTextAlignmentLeft;
            //loginLabel.textColor=[UIColor colorWithRed: 78.0/255.0f green:113.0/255.0f blue:168.0/255.0f alpha:1.0];
            //loginLabel.backgroundColor=[UIColor colorWithRed: 78.0/255.0f green:113.0/255.0f blue:168.0/255.0f alpha:1.0];
            loginLabel.frame = CGRectMake(1, 1, 0, 0);
        }
    }
    fbLoginView.hidden=YES;
    [self.view addSubview:fbLoginView];
    
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    
    
    //self.fbNameLabel.text = [NSString stringWithFormat:@"Welcome %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user

    //self.fbProfileView.profileID = user.objectID;
    self.loggedInUser = user;
    NSLog(@"loggedIN: %@",self.loggedInUser);
    if(self.loggedInUser)
    {
        NSLog(@"fb email= %@",[self.loggedInUser objectForKey:@"email"] );
        NSString *uName = [self.loggedInUser objectForKey:@"email"];
        NSString *eMail = [self.loggedInUser objectForKey:@"email"];
        NSString *gender = @"";
        if ([[self.loggedInUser objectForKey:@"gender"] isEqualToString:@"male"]) {
            gender = @"1";
        }else{
            gender = @"2";

        }
        [sharedPref setValue:uName forKey:@"UserName"];
        [sharedPref setValue:eMail forKey:@"EmailId"];
        [sharedPref setValue:gender forKey:@"Gender"];
        [sharedPref synchronize];

        [sharedPref setBool:YES forKey:@"isLogedin"];

        StepOneViewController *sVC =  [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
        //[self.revealSideViewController popViewControllerWithNewCenterController:sVC  animated:YES];
        [self.navigationController pushViewController:sVC animated:YES];

    }
    
    //[self.twitterButtonLabel setEnabled:NO];
    //self.twitterButtonLabel.userInteractionEnabled = NO;
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
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
    [fbLoginView.subviews[0] sendActionsForControlEvents:UIControlEventTouchUpInside];
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


-(void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier {
    
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

        
        /*
         At this point, the user can use the API and you can read his access tokens with:
         
         _twitter.oauthAccessToken;
         _twitter.oauthAccessTokenSecret;
         
         You can store these tokens (in user default, or in keychain) so that the user doesn't need to authenticate again on next launches.
         
         Next time, just instanciate STTwitter with the class method:
         
         +[STTwitterAPI twitterAPIWithOAuthConsumerKey:consumerSecret:oauthToken:oauthTokenSecret:]
         
         Don't forget to call the -[STTwitter verifyCredentialsWithSuccessBlock:errorBlock:] after that.
         */
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- %@", [error localizedDescription]);
    }];
    
}


- (IBAction)twitterClick:(id)sender {
    
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:TWITTER_CLIENT_KEY
                                                 consumerSecret:TWITTER_CLIENT_SECRET];
    
    
    [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        NSLog(@"-- url: %@", url);
        NSLog(@"-- oauthToken: %@", oauthToken);
        
        
        [[UIApplication sharedApplication] openURL:url];
        
    } authenticateInsteadOfAuthorize:NO
                    forceLogin:@(YES)
                    screenName:nil
                 oauthCallback:@"myapp://twitter_access_tokens/"
                    errorBlock:^(NSError *error) {
                        NSLog(@"-- error: %@", error);
                    }];
    
    
}

@end
