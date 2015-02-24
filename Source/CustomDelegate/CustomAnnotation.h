//
//  CustomAnnotation.h
//  Chosen
//
//  Created by Kaustav Shee on 2/24/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ModelUser.h"

@interface CustomAnnotation : NSObject <MKAnnotation>

@property(readonly,nonatomic) CLLocationCoordinate2D coordinate;
@property(copy,nonatomic) NSString *strTitle;
@property(strong,nonatomic) ModelUser *user;

-(id)initWithTitle:(NSString*)newTitle Location:(CLLocationCoordinate2D)location User:(ModelUser*)myUser;

-(MKAnnotationView*)annotationView;

@end
