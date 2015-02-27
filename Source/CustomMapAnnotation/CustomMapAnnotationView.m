//
//  CustomMapAnnotationView.m
//  Chosen
//
//  Created by Kaustav Shee on 2/25/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "CustomMapAnnotationView.h"

@implementation CustomMapAnnotationView

@synthesize name = _name;
@synthesize description = _description;
@synthesize coordinate = _coordinate;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate
{
    self=[super init];
    if(self){
        _coordinate=coordinate;
    }
    return self;
}
-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
    {
        [self.superview bringSubviewToFront:self];
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    if(!isInside)
    {
        for (UIView *view in self.subviews)
        {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
            break;
        }
    }
    return isInside;
}
- (void)setShowCustomCallout:(BOOL)showCustomCallout
{
    [self setShowCustomCallout:showCustomCallout animated:NO];
}

- (void)setShowCustomCallout:(BOOL)showCustomCallout animated:(BOOL)animated
{
    if (_showCustomCallout == showCustomCallout) return;
    
    _showCustomCallout = showCustomCallout;
    
    void (^animationBlock)(void) = nil;
    void (^completionBlock)(BOOL finished) = nil;
    
    if (_showCustomCallout) {
        self.calloutView.alpha = 0.0f;
        
        animationBlock = ^{
            self.calloutView.alpha = 1.0f;
            [self addSubview:self.calloutView];
        };
        
    } else {
        animationBlock = ^{ self.calloutView.alpha = 0.0f; };
        completionBlock = ^(BOOL finished) { [self.calloutView removeFromSuperview]; };
    }
    
    if (animated) {
        [UIView animateWithDuration:0.2f animations:animationBlock completion:completionBlock];
        
    } else {
        animationBlock();
        completionBlock(YES);
    }
}

//-(void) dealloc{
//    [super dealloc];
//    self.name = nil;
//    self.description = nil;
//}
@end
