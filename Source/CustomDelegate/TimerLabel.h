//
//  TimerLabel.h
//  TestImageTouch
//
//  Created by Kaustav Shee on 4/13/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol TimerLabelDelegate <NSObject>

@required

-(NSDate*)getCurrentTime;
-(NSTimeInterval)displayForTimeInterval;

@end


@interface TimerLabel : UILabel

@property(weak,nonatomic) id <TimerLabelDelegate> delegate;

-(void)startCountDownTimer;

@end
