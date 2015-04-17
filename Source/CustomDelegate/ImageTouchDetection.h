//
//  ImageTouchDetection.h
//  ColorPickerFromImage
//
//  Created by Kaustav Shee on 3/31/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageTouchDetectionDelegate <NSObject>

@required

-(NSTimeInterval)willShowExplotionForSecond;

@optional

-(void)didAnimationStoppedOwn;
-(void)didAnimationStartedOwn;

-(void)didHitTargetOwn;
-(void)didMissTargetOwn;

-(void)didAnimationStartedRival;
-(void)didAnimationStoppedRival;

@end








@interface ImageTouchDetection : UIImageView

@property(weak,nonatomic) id <ImageTouchDetectionDelegate> delegate;


-(void)startAnimatorOwn;
-(void)stopAnimatorOwn;

-(void)startAnimationRivalAtPoint:(CGPoint)point;
-(void)stopAnimationRival;

@end
