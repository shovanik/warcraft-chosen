//
//  TimerLabel.m
//  TestImageTouch
//
//  Created by Kaustav Shee on 4/13/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

/*
 -(NSDate*)getCurrentTime;
 -(NSTimeInterval)displayForTimeInterval;
 */


#import "TimerLabel.h"


@interface TimerLabel ()
{
    NSDate *dateTimeUptoDisplay;
}

@end

@implementation TimerLabel

@synthesize delegate;

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)startCountDownTimer
{
    dateTimeUptoDisplay=[[delegate getCurrentTime] dateByAddingTimeInterval:[delegate displayForTimeInterval]];
    NSLog(@"Current Time = %@",[delegate getCurrentTime]);
    NSLog(@"To Time = %@",dateTimeUptoDisplay);
    NSThread *myThread=[[NSThread alloc] initWithTarget:self selector:@selector(startCounter) object:nil];
    [myThread start];
}

-(void)startCounter
{
    @synchronized(self){
        while ([dateTimeUptoDisplay timeIntervalSinceDate:[NSDate date]]>0) {
            NSTimeInterval intervalTime=[dateTimeUptoDisplay timeIntervalSinceDate:[NSDate date]];
            
            
//            NSLog(@"Time Interval = %f",intervalTime);
            
            
            NSInteger minute=intervalTime/60;
            
            
//            NSLog(@"Minute = %ld",(long)minute);
            
            
            NSTimeInterval timeIntervalRemain=intervalTime-(minute*60);
            
            
//            NSLog(@"Time Interval = %f",timeIntervalRemain);
//            NSLog(@"abs = %d",abs(timeIntervalRemain));
//            NSLog(@"labs = %ld",labs(timeIntervalRemain));
//            NSLog(@"llabs = %lld",llabs(timeIntervalRemain));
//            NSLog(@"fabs = %f",fabs(timeIntervalRemain));
//            NSLog(@"fabsf = %f",fabsf(timeIntervalRemain));
//            NSLog(@"fabsl = %Lf",fabsl(timeIntervalRemain));
//            NSLog(@"fmodf = %0.3f",fmodf(timeIntervalRemain, 1.0));
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.text=[NSString stringWithFormat:@"%02ld:%02d:%0.3f",(long)minute,abs(timeIntervalRemain),fmodf(timeIntervalRemain, 1.0)];
                NSLog(@"%@",[NSString stringWithFormat:@"%02ld:%02d:%0.3f",(long)minute,abs(timeIntervalRemain),fmodf(timeIntervalRemain, 1.0)]);
            }];
        }
    }
}

@end
