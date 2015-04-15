//
//  ImageViewExplotion.m
//  ColorPickerFromImage
//
//  Created by Kaustav Shee on 3/31/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import "ImageViewExplotion.h"

@implementation ImageViewExplotion

-(id)init
{
    if (self=[super init]) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        [self initialize];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    if (self=[super initWithImage:image highlightedImage:highlightedImage]) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    self.dateStartTime=[NSDate date];
}

@end
