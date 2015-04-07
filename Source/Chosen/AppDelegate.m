//
//  AppDelegate.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import "AppDelegate.h"
#import "LandingViewController.h"
#import <Social/Social.h>
#import "LandingViewController.h"
#import "SlideOutMenuViewController.h"

#import "STTwitter.h"


@interface AppDelegate ()
{
    
}

@end

@implementation AppDelegate


@synthesize navigationcontroller;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    LandingViewController *landingViewController =  [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
    navigationcontroller = [[UINavigationController alloc]initWithRootViewController:landingViewController];
    navigationcontroller.navigationBarHidden = YES;
    
    
    
    
    self.window.rootViewController=navigationcontroller;
    
    slideMenu=[[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController_iPhone4" bundle:nil];
    slideMenu.view.frame=[[UIScreen mainScreen] bounds];
    NSLog(@"master = %@",NSStringFromCGRect(slideMenu.view.frame));
    [self.window addSubview:slideMenu.view];
    
    
    [self.window makeKeyAndVisible];
    
    
    [FBLoginView class];
    [FBProfilePictureView class];
    
    //[self lastSeenCalling];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //NSLog(@"%@",url);
    
    
    //LandingViewController *landingViewController =  (LandingViewController *)[_revealSideViewController rootViewController];
    
    if ([ [url absoluteString] rangeOfString:@"com.facebook.sdk_client_state"].location == NSNotFound) {
        
        if ([ [url absoluteString] rangeOfString:@"twitter_access_tokens"].location == NSNotFound)
        {}
        else
        {
            NSLog(@"Twitter Loop");
            if ([[url scheme] isEqualToString:@"myapp"] == NO) return NO;
            
            NSDictionary *d = [self parametersDictionaryFromQueryString:[url query]];
            
            
            //[landingViewController setOAuthToken:token oauthVerifier:verifier];
        }
        return YES;
    }
    else
    {
        NSLog(@"Facebook Loop");
        // attempt to extract a token from the url
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call)
        {
            NSLog(@"In fallback handler");
        
        }];
    }
}


- (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
}




#pragma mark - Locationmanager Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
}

-(void)localnotification
{
    
}
#pragma mark
#pragma mark Last Seen API Calling
#pragma mark

-(void)lastSeenCalling
{
    if (user) {
        [[WebService service] callLastSeenServiceForUserID:user.strID WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            NSLog(@"response = %@",strMessage);
            
            [self performSelector:@selector(lastSeenCalling) withObject:nil afterDelay:30.0];
        }];
    }else{
        [self performSelector:@selector(lastSeenCalling) withObject:nil afterDelay:30.0];
    }
}


@end
