//
//  AttackViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 4/3/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AttackViewController.h"
#import "GuildImageView.h"
#import "ImageTouchDetection.h"
#import "ImageViewExplotion.h"
#import "TimerLabel.h"

@interface AttackViewController ()<ImageTouchDetectionDelegate,TimerLabelDelegate>
{
    IBOutlet GuildImageView *imgSliderOwn;
    IBOutlet GuildImageView *imgSliderRival;
    IBOutlet ImageTouchDetection *imgMain;
    
    IBOutlet UIImageView *imgTimerLeft;
    IBOutlet UIImageView *imgTimerRight;
    IBOutlet TimerLabel *lblLeft;
    IBOutlet TimerLabel *lblRight;
}

@end

@implementation AttackViewController

#pragma mark
#pragma mark Initialization
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [imgSliderOwn setSliderColor:[UIColor blueColor]];
    [imgSliderRival setSliderColor:[UIColor redColor]];
    
    [imgSliderOwn setPercentage:85];
    [imgSliderRival setPercentage:45];
    
    
    NSMutableArray *arrImages=[[NSMutableArray alloc] init];
    for (int i=1; i<=20; i++) {
        [arrImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
    
    if (imgMain) {
        imgMain.delegate=self;
    }
    
    if (lblLeft) {
        lblLeft.delegate=self;
    }
    
    if (lblRight) {
        lblRight.delegate=self;
    }
    
    imgTimerLeft.animationImages=imgTimerRight.animationImages=arrImages;
    imgTimerLeft.animationDuration=imgTimerRight.animationDuration=2.0;
    imgTimerLeft.animationRepeatCount=imgTimerRight.animationRepeatCount=0;
    [imgTimerLeft startAnimating];
    [imgTimerRight startAnimating];
    imgTimerLeft.hidden=imgTimerRight.hidden=YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Start Game" message:@"Please select whether you are ready to start game or not" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:^{
            
        }];
        [self startAnimation];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [controller addAction:actionOK];
    [controller addAction:actionCancel];
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark ImageTouchDetectionDelegate
#pragma mark


-(NSTimeInterval)willShowExplotionForSecond
{
    return 5.0;
}

-(void)didHitTargetOwn
{
    for (UILocalNotification *localNotification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        
        if ([[localNotification.userInfo objectForKey:@"UserID"] isEqualToString:user.strID]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification] ;
            [self stopAnimation];
            NSLog(@"UserInfo = %@",localNotification.userInfo);
            break;
        }
    }
}
-(void)didMissTargetOwn
{
    for (UILocalNotification *localNotification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        
        if ([[localNotification.userInfo objectForKey:@"UserID"] isEqualToString:user.strID]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification] ;
            [self stopAnimation];
            NSLog(@"UserInfo = %@",localNotification.userInfo);
            break;
        }
    }
}

#pragma mark
#pragma mark TimerLabelDelegate
#pragma mark

-(NSDate*)getCurrentTime
{
    return [NSDate date];
}
-(NSTimeInterval)displayForTimeInterval
{
    return [self willShowExplotionForSecond];
}

#pragma mark
#pragma mark Helper Method For Own
#pragma mark

-(void)startAnimation
{
    [imgMain startAnimatorOwn];
    [self scheduleLocalNotificationForStop];
}

-(void)stopAnimation
{
    [imgMain stopAnimatorOwn];
}


-(void)didAnimationStoppedOwn
{
    //[self performSelector:@selector(startAnimation) withObject:nil afterDelay:[self willShowExplotionForSecond]];
    
    [self startRivalAnimation];
}
-(void)didAnimationStartedOwn
{
    imgTimerLeft.hidden=NO;
    imgTimerRight.hidden=YES;
    [lblLeft startCountDownTimer];
}


-(void)scheduleLocalNotificationForStop
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:[self willShowExplotionForSecond]];
    localNotification.alertBody = @"My notification text";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    NSDictionary *dict=[[NSDictionary alloc] initWithObjects:@[user.strID,@"OWN"] forKeys:@[@"UserID",@"Player"]];
    localNotification.userInfo=dict;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark
#pragma mark Helper Method For Rival
#pragma mark

-(void)startRivalAnimation
{
    UIGraphicsBeginImageContext(imgMain.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [imgMain.layer renderInContext:context];
    
    int bpr =(int) CGBitmapContextGetBytesPerRow(context);
    unsigned char * data = CGBitmapContextGetData(context);
    
    while (1)
    {
        int randomX = arc4random()%(u_int32_t)imgMain.frame.size.width;
        int randomY = arc4random()%(u_int32_t)imgMain.frame.size.height;
        CGPoint myPoint=CGPointMake(randomX, randomY);
        
        int offset = bpr*round(myPoint.y) + 4*round(myPoint.x);
        int blue = data[offset+0];
        int green = data[offset+1];
        int red = data[offset+2];
        int alpha =  data[offset+3];
        
        CGFloat derivedAlpha=alpha/255.0f;
        
        NSLog(@"%d %d %d %d %f", alpha, red, green, blue,derivedAlpha);
        if (alpha > 0)
        {
            [imgMain startAnimationRivalAtPoint:myPoint];
            return;
        }
        else
        {
            continue;
        }
    }
}

-(void)stopRivalAnimation
{
    [imgMain stopAnimationRival];
}

-(void)didAnimationStartedRival
{
    [self scheduleLocalNotificationForRivalToStop];
}

-(void)didAnimationStoppedRival
{
    [self startAnimation];
}

-(void)scheduleLocalNotificationForRivalToStop
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:[self willShowExplotionForSecond]];
    localNotification.alertBody = @"My notification text";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    NSDictionary *dict=[[NSDictionary alloc] initWithObjects:@[user.strID,@"RIVAL"] forKeys:@[@"UserID",@"Player"]];
    localNotification.userInfo=dict;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark
#pragma mark Did Recive Local Notification
#pragma mark

-(void)didReceiveLocalNotifications:(UILocalNotification *)notification
{
    NSLog(@"UserInfo = %@",notification.userInfo);
    if ([user.strID isEqualToString:[notification.userInfo objectForKey:@"UserID"]] && [[notification.userInfo objectForKey:@"Player"] isEqualToString:@"OWN"]) {
        [self stopAnimation];
    }
    if ([user.strID isEqualToString:[notification.userInfo objectForKey:@"UserID"]] && [[notification.userInfo objectForKey:@"Player"] isEqualToString:@"RIVAL"]) {
        [self stopRivalAnimation];
    }
}


@end
