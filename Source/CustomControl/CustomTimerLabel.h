//
//  CustomTimerLabel.h
//  CountDownTimer
//
//  Created by Kaustav Shee on 5/14/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimerLabelDelegate <NSObject>

@required
-(NSInteger)displayForSecond;

@optional
-(void)didStartTimer;
-(void)didStopTimer;
-(void)didResetTimer;

@end

@interface CustomTimerLabel : UILabel

@property(weak,nonatomic) id <TimerLabelDelegate> delegate;

-(void)start;
-(void)stop;
-(void)reset;

@end
