//
//  CustomTimerLabel.m
//  CountDownTimer
//
//  Created by Kaustav Shee on 5/14/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import "CustomTimerLabel.h"

@interface CustomTimerLabel ()
{
    NSTimer *timer;
    NSDate *dateStart;
}

@end

@implementation CustomTimerLabel

-(id)init
{
    if (self=[super init]) {
        [self initialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

-(void)initialization
{
    
}

-(void)setTextValueForTimeInterval:(NSTimeInterval)interval
{
    NSInteger hour=interval/3600;
    interval-=(hour*3600);
    NSInteger min=interval/60;
    interval-=(min*60);
    NSInteger sec=interval;
    [self setText:[NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec]];
}

-(void)start
{
    dateStart=[NSDate date];
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0/100.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStartTimer)]) {
        [self.delegate didStartTimer];
    }
}

-(void)stop
{
    self.text=@"00:00:000";
    [timer invalidate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStopTimer)]) {
        [self.delegate didStopTimer];
    }
}

-(void)reset
{
    self.text=@"00:00:000";
    [timer invalidate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didResetTimer)]) {
        [self.delegate didResetTimer];
    }
}

-(void)timerFired
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate
                                   timeIntervalSinceDate:dateStart];
    NSLog(@"\n\ntime interval %f",timeInterval);
    
    //[self.delegate displayForSecond] seconds count down
    NSTimeInterval timeIntervalCountDown = [self.delegate displayForSecond] - timeInterval;
    NSLog(@"timeIntervalCountDown %f\n\n",timeIntervalCountDown);
    
    /*if (timeInterval>[self.delegate displayForSecond]) {
        NSLog(@"Time Over");
    }*/
    
    /*
    NSDate *timerDate = [NSDate
                         dateWithTimeIntervalSince1970:timeIntervalCountDown];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"00:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    //self.stopWatch.text = timeString;
    self.text=timeString;
     */
    
    if (timeIntervalCountDown>0) {
        NSInteger hour=(NSInteger)timeIntervalCountDown/3600;
        timeIntervalCountDown-=(hour*3600);
        NSInteger min=(NSInteger)timeIntervalCountDown/60;
        timeIntervalCountDown-=(min*60);
        CGFloat sec=timeIntervalCountDown;
        self.text=[NSString stringWithFormat:@"%02d:%02d:%02.3f",hour,min,sec];
    }else{
        self.text=@"00:00:000";
        [timer invalidate];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didStopTimer)]) {
            [self.delegate didStopTimer];
        }
    }
    
}

@end
