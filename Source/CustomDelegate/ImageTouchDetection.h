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

-(void)willImageStartLoading;
-(void)didImageFinishedLoading;

@end








@interface ImageTouchDetection : UIImageView

@property(weak,nonatomic) id <ImageTouchDetectionDelegate> delegate;
@property(strong,nonatomic) NSData *imgData;


-(void)startAnimatorOwn;
-(void)stopAnimatorOwn;

-(void)startAnimationRivalAtPoint:(CGPoint)point;
-(void)stopAnimationRival;

-(void)loadImageFromURL:(NSURL*)imgURL;

@end
