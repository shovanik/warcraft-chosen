//
//  ImageTouchDetection.h
//  ColorPickerFromImage
//
//  Created by Kaustav Shee on 3/31/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageTouchDetectionDelegate <NSObject>

@optional

-(void)didClickedOnImageWithLocation:(CGPoint)touchLocation RGB:(UIColor*)color Alpha:(CGFloat)alpha;
-(void)didClickedBlankPortion;


@end

@interface ImageTouchDetection : UIImageView

@property(weak,nonatomic) id <ImageTouchDetectionDelegate> delegate;

@end
