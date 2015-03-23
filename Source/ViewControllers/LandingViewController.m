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
#import "CustomMapAnnotationView.h"


NSUserDefaults *sharedPref;

@interface LandingViewController ()
@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation LandingViewController
@synthesize cpLabel;
FBLoginView *fbLoginView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
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
            loginLabel.frame = CGRectMake(1, 1, 0, 0);
        }
    }
    fbLoginView.hidden=YES;
    [self.view addSubview:fbLoginView];
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
        [self.navigationController pushViewController:sVC animated:YES];

    }
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
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
