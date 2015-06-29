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
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "WebServiceConstant.h"
#import "CustomTimerLabel.h"
#import "SocketService.h"

@interface AttackViewController ()<ImageTouchDetectionDelegate,SocketIODelegate,TimerLabelDelegate>
{
    IBOutlet GuildImageView *imgSliderOwn;
    IBOutlet GuildImageView *imgSliderRival;
    IBOutlet ImageTouchDetection *imgMain;
    
    IBOutlet UIImageView *imgTimerLeft;
    IBOutlet UIImageView *imgTimerRight;
    
    IBOutlet CustomTimerLabel *lblTimerLeft;
    IBOutlet CustomTimerLabel *lblTimerRight;
    
    IBOutlet UILabel *lblLifeOwn;
    IBOutlet UILabel *lblLifeOther;
    
    BOOL isOponentImageDownloaded;
    BOOL isSelfImageDownloadComplete;
    
    BOOL isFirstHit;
    
    CGFloat prevPercentage;
}

@end

@implementation AttackViewController

#pragma mark
#pragma mark Initialization
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [imgSliderOwn setSliderColor:[UIColor blueColor]];
    [imgSliderRival setSliderColor:[UIColor redColor]];
    
    [imgSliderOwn setPercentage:100];
    [imgSliderRival setPercentage:100];
    
    lblLifeOwn.text=lblLifeOther.text=@"100";
    lblTimerLeft.delegate=self;
    
    imgSliderRival.transform=CGAffineTransformMakeRotation(M_PI);
    
    NSMutableArray *arrImages=[[NSMutableArray alloc] init];
    for (int i=1; i<=20; i++) {
        [arrImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
    
    if (imgMain) {
        imgMain.delegate=self;
    }
    
    imgTimerLeft.animationImages=imgTimerRight.animationImages=arrImages;
    imgTimerLeft.animationDuration=imgTimerRight.animationDuration=2.0;
    imgTimerLeft.animationRepeatCount=imgTimerRight.animationRepeatCount=0;
    [imgTimerLeft startAnimating];
    [imgTimerRight startAnimating];
    imgTimerLeft.hidden=imgTimerRight.hidden=YES;
    isOponentImageDownloaded=NO;
    isSelfImageDownloadComplete=NO;
    [imgMain loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",__kBaseURL,[userRival.strAvtarImage stringByReplacingOccurrencesOfString:@"thumb" withString:@"big"]]]];
    
    isFirstHit=YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    prevPercentage=imgSliderOwn.parcentage;
}


-(void)startOfGame
{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Start Game" message:@"Please select the ok button to startup the game" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:^{
            
        }];
        [self startAnimation];
    }];
    [controller addAction:actionOK];
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

-(void)didHitTargetOwnWithDistance:(CGFloat)distance
{
    
    
    
    //[self sendHitWithStatus:@"HIT" Distance:[NSString stringWithFormat:@"%f",distance]];
    NSLog(@"Distance = %f",distance);
    
    
    CGFloat damage;
    if (distance>0 && distance<2) {
        damage=5.0f;
    }
    else if (distance>2 && distance<7){
        damage=2.5f;
    }
    else if (distance>7 && distance<12){
        damage=1.25f;
    }
    else if (distance>12 && distance<17){
        damage=0.625f;
    }
    else if (distance>17){
        damage=0.3125f;
    }
    
    
    if (isFirstHit) {
        [self sendBeginFight];
        isFirstHit=NO;
        
    }
    
    if (imgSliderRival.parcentage-damage>0) {
        
        [imgSliderRival setPercentage:imgSliderRival.parcentage-damage];
        lblLifeOther.text=[NSString stringWithFormat:@"%d",(int)imgSliderRival.parcentage];
        
        
        [self sendHitWithIsHit:YES HitValue:[NSString stringWithFormat:@"%f",prevPercentage-imgSliderRival.parcentage]];
        prevPercentage=imgSliderRival.parcentage;
    }else{
        [imgSliderRival setPercentage:0];
        lblLifeOther.text=[NSString stringWithFormat:@"0"];
        
        
        [self sendHitWithIsHit:YES HitValue:[NSString stringWithFormat:@"%f",/*prevPercentage-imgSliderRival.parcentage*/50.0f]];
        prevPercentage=imgSliderRival.parcentage;
    }
    
    
    
    
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
    //[self sendHitWithStatus:@"MISS" Distance:@"-1.0"];
    [self sendHitWithIsHit:NO HitValue:@"0.0"];
    
    for (UILocalNotification *localNotification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([[localNotification.userInfo objectForKey:@"UserID"] isEqualToString:user.strID]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification] ;
            [self stopAnimation];
            NSLog(@"UserInfo = %@",localNotification.userInfo);
            break;
        }
    }
}

-(void)willImageStartLoading
{
    [self.activityIndicatorView startAnimating];
}

-(void)didImageFinishedLoading
{
    [self.activityIndicatorView stopAnimating];
    isSelfImageDownloadComplete=YES;
    
    if (_isStartFightReceived && isSelfImageDownloadComplete) {
        [self sendReadyToFight];
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
    
    //[self startRivalAnimation];
    
    [imgTimerLeft stopAnimating];
    [lblTimerLeft stop];
}
-(void)didAnimationStartedOwn
{
    [lblTimerLeft start];
    imgTimerLeft.hidden=NO;
    [imgTimerLeft startAnimating];
    imgTimerRight.hidden=YES;
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
    //[self sendHitWithStatus:@"MISS" Distance:@"-1.0"];
    [self sendHitWithIsHit:NO HitValue:@"0.0"];
    NSLog(@"UserInfo = %@",notification.userInfo);
    
    if ([user.strID isEqualToString:[notification.userInfo objectForKey:@"UserID"]] && [[notification.userInfo objectForKey:@"Player"] isEqualToString:@"OWN"]) {
        [self stopAnimation];
    }
    if ([user.strID isEqualToString:[notification.userInfo objectForKey:@"UserID"]] && [[notification.userInfo objectForKey:@"Player"] isEqualToString:@"RIVAL"]) {
        [self stopRivalAnimation];
    }
}

#pragma mark
# pragma mark socket.IO-objc delegate methods
#pragma mark

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"%@",packet.data);
    NSLog(@"%@",packet.dataAsJSON);
    
    NSDictionary *dict=packet.dataAsJSON;
    
    /*if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[StartFight]]) {
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
    }*/
    
    
    
    if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[ReadyToFight]]) {
        NSLog(@"This is ReadyToFight.");
        isOponentImageDownloaded=YES;
        if (!imgMain.image) {
            [self sendReadyToFightResponse:@"WAIT"];
        }else{
            [self sendReadyToFightResponse:@"READY"];
        }
        
    }
    else if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[ReadyToFightResponse]]) {
        NSLog(@"This is ReadyToFightResponse.");
        
        NSDictionary *dict=(NSDictionary*)packet.dataAsJSON;
        dict=[(NSArray*)[dict objectForKey:@"args"] objectAtIndex:0];
        if ([[dict objectForKey:@"meta"] isEqualToString:@"READY"]) {
            isOponentImageDownloaded=YES;
            [self startOfGame];
        }else{
            [self sendReadyToFight];
        }
    }
    
    else if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[SendHit]]) {
        NSDictionary *dict=packet.dataAsJSON;
        dict=[(NSArray*)[dict objectForKey:@"args"] objectAtIndex:0];
        dict=[dict objectForKey:@"meta"];
        CGFloat damage;
        
        if ([[dict objectForKey:@"hit"] floatValue]==0) {
            damage=0.0f;
        }else{
            damage=[[dict objectForKey:@"hitValue"] floatValue];
        }
        
        /*
        if (imgSliderOwn.parcentage-damage>=0) {
            [imgSliderOwn setPercentage:imgSliderOwn.parcentage-damage];
            lblLifeOwn.text=[NSString stringWithFormat:@"%d",(int)imgSliderOwn.parcentage];
        }
        */
        
        if (imgSliderOwn.parcentage-damage>0) {
            [imgSliderOwn setPercentage:imgSliderOwn.parcentage-damage];
            lblLifeOwn.text=[NSString stringWithFormat:@"%d",(int)imgSliderOwn.parcentage];
        }else{
            [imgSliderOwn setPercentage:0];
            lblLifeOwn.text=[NSString stringWithFormat:@"0"];
        }
        
        
        
        /*
        if ([dict objectForKey:@"Distance"] && ![[dict objectForKey:@"Distance"] isKindOfClass:[NSNull class]]) {
            if ([[dict objectForKey:@"Distance"] floatValue]>0 && [[dict objectForKey:@"Distance"] floatValue]<2) {
                damage=5.0f;
            }
            else if ([[dict objectForKey:@"Distance"] floatValue]>2 && [[dict objectForKey:@"Distance"] floatValue]<7){
                damage=2.5f;
            }
            else if ([[dict objectForKey:@"Distance"] floatValue]>7 && [[dict objectForKey:@"Distance"] floatValue]<12){
                damage=1.25f;
            }
            else if ([[dict objectForKey:@"Distance"] floatValue]>12 && [[dict objectForKey:@"Distance"] floatValue]<17){
                damage=0.625f;
            }
            else if ([[dict objectForKey:@"Distance"] floatValue]>17){
                damage=0.3125f;
            }
            else if ([[dict objectForKey:@"Distance"] floatValue]==-1.0f){
                damage=0.0f;
            }
            
            if (imgSliderOwn.parcentage-damage>=0) {
                [imgSliderOwn setPercentage:imgSliderOwn.parcentage-damage];
                lblLifeOwn.text=[NSString stringWithFormat:@"%d",(int)imgSliderOwn.parcentage];
            }else{
                //Oponent Win...
                
                UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Sorry" message:@"Oponents have win" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [controller dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [controller addAction:actionOk];
                [self presentViewController:controller animated:YES completion:^{
                    
                }];
            }
        }
         */
        
        
        [self startAnimation];
    }
    
    else if ([[dict objectForKey:@"name"] isEqualToString:socketEvents[endFight]]){
        NSDictionary *dict=(NSDictionary*)packet.dataAsJSON;
        NSLog(@"Response = %@",dict);
        NSDictionary *dictFinalResult=[(NSArray*)[dict objectForKey:@"args"] objectAtIndex:0];
        //[imgSliderOwn setPercentage:0];
        
        [[SocketService service] makeSocketDelegate:self.parentViewController];
        
        if ([user.strID isEqualToString:[dictFinalResult objectForKey:@"winner_id"]]) {
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Congrats" message:@"You have win the match..." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }else{
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Sorry" message:@"Oponent have win the match..." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
    }
}

#pragma mark
#pragma mark CustomerTimerLabel Delegate
#pragma mark

-(NSInteger)displayForSecond
{
    return [self willShowExplotionForSecond];
}

-(void)didStartTimer
{
    
}

-(void)didStopTimer
{
    
}

-(void)didResetTimer
{
    
}


@end
