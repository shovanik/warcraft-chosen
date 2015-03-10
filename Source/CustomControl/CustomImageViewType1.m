//
//  CustomImageViewType1.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "CustomImageViewType1.h"

@implementation CustomImageViewType1

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
    self.layer.borderWidth=1.5f;
    self.layer.borderColor=[[UIColor colorWithRed:136.0f/255.0f green:168.0f/255.0f blue:180.0f/255.0f alpha:0.4f] CGColor];
}

@end
