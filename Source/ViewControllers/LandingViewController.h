//
//  LandingViewController.h
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//
#import <Social/Social.h>
#import "BaseViewController.h"

#define TWITTER_CLIENT_KEY @"Gu0LAGiLrrCVWSq8oQlGIS4Ox"
#define TWITTER_CLIENT_SECRET @"mSQuk3GNvM8MbyjWfPDOBzTHwqZSoiMcq1mpvPxsKKrJBcWzNU"

@interface LandingViewController : BaseViewController
{
    
}
- (IBAction)fbloginClick:(id)sender;
-(IBAction)loginButtonTapped:(id)sender;
-(IBAction)registerButtonTapped:(id)sender;
- (IBAction)twitterClick:(id)sender;
@property (nonatomic, strong) IBOutlet UILabel *cpLabel;

-(void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verfier;
@end
