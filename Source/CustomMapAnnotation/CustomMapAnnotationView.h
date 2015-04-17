//
//  CustomMapAnnotationView.h
//  Chosen
//
//  Created by Kaustav Shee on 2/25/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnotationViewController.h"
#import "ModelUser.h"

@class ModelUser;
@interface CustomMapAnnotationView : MKPinAnnotationView<MKAnnotation>
{
    NSString *_name;
    NSString *_description;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, retain) NSString *name;
//@property (nonatomic, retain) NSString *description;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property(assign,nonatomic) BOOL showCustomCallout;
@property(strong,nonatomic) UIView *calloutView;
@property(strong,nonatomic) AnnotationViewController *annotationViewController;
@property(strong,nonatomic) ModelUser *user;


-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
