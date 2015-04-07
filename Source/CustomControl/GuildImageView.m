//
//  GuildImageView.m
//  Chosen
//
//  Created by Kaustav Shee on 3/13/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "GuildImageView.h"

@interface GuildImageView ()
{
    UIImageView *imgSlider;
}

@end

@implementation GuildImageView

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

-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        [self initialization];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    if (self=[super initWithImage:image highlightedImage:highlightedImage]) {
        [self initialization];
    }
    return self;
}

-(void)initialization
{
    self.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
    imgSlider=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    [self addSubview:imgSlider];
    imgSlider.backgroundColor=[UIColor colorWithRed:24.0f/255.0f green:63.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
}

-(void)setSliderColor:(UIColor *)color
{
    imgSlider.backgroundColor=color;
}

-(void)setPercentage:(NSInteger)percentage
{
    
    UIImageView *img=nil;
    if (self.subviews.count>0) {
        for (id obj in self.subviews) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                img=(UIImageView*)obj;
                break;
            }
        }
        CGFloat width=(self.frame.size.width*percentage)/100;
        [UIView animateWithDuration:0.3 animations:^{
            img.frame=CGRectMake(0, 0, width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

@end
