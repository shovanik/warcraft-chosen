//
//  ImageViewGuild.m
//  Chosen
//
//  Created by Kaustav Shee on 3/11/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ImageViewGuild.h"

@interface ImageViewGuild ()
{
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation ImageViewGuild

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
    activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center=self.center;
    [activityIndicator setHidesWhenStopped:YES];
    [self addSubview:activityIndicator];
    self.contentMode=UIViewContentModeScaleAspectFit;
}

-(void)setImageFromURL:(NSString *)strURL
{
    [activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            if (imgData.length>0) {
                self.image=[UIImage imageWithData:imgData];
            }else{
                self.image=nil;
            }
        });
    });
}


@end
