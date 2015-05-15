//
//  WorldMapViewController.m
//  Chosen
//
//  Created by AppsbeeTechnology on 09/02/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WorldMapViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "AnnotationViewController.h"
#import "AttackViewController.h"
#import "NSMutableArray+FoundUser.h"

//#define MileConversionParameter 0.621371192
//
NSUserDefaults *pref;

@interface WorldMapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,AnnotationViewControllerDelegate>
{
    
    IBOutlet MKMapView *wrldMapView;

    CGFloat _offset;
    CGFloat distancePerMile;
    CLLocationManager *locationManager;
    
    NSMutableArray *arrAnnotations;
    
    AnnotationViewController *annotationViewController;
    
    ModelUser *userSelected;
}
//@property (nonatomic, strong) NSString *mapRadious;

@end

@implementation WorldMapViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   _offset = 50;
    distancePerMile = 5*1609.344;
    
    //wrldMapView.delegate=nil;
    arrAnnotations=[[NSMutableArray alloc] init];
    
    annotationViewController=[[AnnotationViewController alloc] initWithNibName:@"AnnotationViewController" bundle:nil];
    annotationViewController.isCallOutOpen=NO;
    annotationViewController.delegate=self;
    
    
    if(locationManager==nil)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Location Manager Delegate Method
#pragma mark


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [locationManager stopUpdatingLocation];
    
    CLLocationCoordinate2D center;
    CLLocation *location=[locations lastObject];
    center.latitude=location.coordinate.latitude;
    center.longitude=location.coordinate.longitude;
    
    MKCircle *circle=[MKCircle circleWithCenterCoordinate:center radius:distancePerMile];
    [wrldMapView addOverlay:circle];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error) {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something is wrong, please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             alert.tag=1;
             [alert show];
         }else{
             MKCoordinateRegion region;
             region.center=center;
             NSLog(@"Latitude = %f, longitude = %f",region.center.latitude, region.center.longitude );
             double miles = 5.0;
             double scalingFactor = ABS( (cos(2 * M_PI * region.center.latitude / 360.0) ));
             MKCoordinateSpan span;
             span.latitudeDelta = miles/27;
             span.longitudeDelta = miles/(scalingFactor * 27);
             region.span = span;
             [wrldMapView regionThatFits:region];
             [wrldMapView setRegion:region animated:YES];
             [wrldMapView setShowsUserLocation:YES];
             [self callUpdateUserWebServiceWithPlaceMarks:placemarks];
         }
     }];
}


#pragma mark
#pragma mark MapView Delegate Method
#pragma mark

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
        circleView.fillColor = [UIColor colorWithRed:4/255.0f green:86/255.0f blue:163/255.0f alpha:0.5];
        circleView.strokeColor =[UIColor colorWithRed:4/255.0f green:86/255.0f blue:136/255.0f alpha:0.3];
        circleView.lineWidth = 100;
        return circleView;
    }
    else
        return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    
    MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        if (!pinView)
        {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.image = [UIImage imageNamed:@"location_icon.png"];
            pinView.calloutOffset = CGPointMake(0, 0);
        } else {
            pinView.annotation = annotation;
        }
        NSLog(@"Latitude = %f Longitude = %f",annotation.coordinate.latitude,annotation.coordinate.longitude);
        return pinView;
        
    }
    /*if([annotation isKindOfClass:[CustomMapAnnotationView class]]){
        CustomMapAnnotationView *annotationView=(CustomMapAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if(!annotationView){
            annotationView=[[CustomMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            annotationView.image=[UIImage imageNamed:@"whi_point.png"];
            //annotationView.tag=annotationNo;
        }else{
            annotationView.annotation=annotation;
            //annotationView.tag=annotationNo;
        }
        NSLog(@"Latitude = %f Longitude = %f",annotation.coordinate.latitude,annotation.coordinate.longitude);
        
        NSLog(@"Index = %lu",(unsigned long)[arrAnnotations indexOfObject:annotation]);
        annotationView.user=[allUser objectAtIndex:[arrAnnotations indexOfObject:annotation]];
        return annotationView;
    }*/
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            //pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"whi_point.png"];
            //pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    [wrldMapView reloadInputViews];
    /*if ([view isKindOfClass:[CustomMapAnnotationView class]]) {
        CustomMapAnnotationView *customAnnotation=(CustomMapAnnotationView*)view;
        NSLog(@"Tag = %ld",(long)customAnnotation.tag);
        if (annotationViewController.isCallOutOpen) {
            UIView *vw=annotationViewController.view;
            annotationViewController.isCallOutOpen=NO;
            [vw removeFromSuperview];
        }else{
            ModelUser *obj=[allUser objectAtIndex:customAnnotation.tag];
            annotationViewController.lblUserName.text=obj.strUserName;
            annotationViewController.lblUserCountry.text=obj.strCountryName;
            UIView *vw=annotationViewController.view;
            vw.frame=CGRectMake(-10, -view.frame.size.height/2-100, 300, 100);
            annotationViewController.isCallOutOpen=YES;
            
            annotationViewController.lblUserName.text=obj.strUserName;
            annotationViewController.lblUserCountry.text=obj.strCountryName;
            
            [view addSubview:vw];
        }
        ModelUser *obj=customAnnotation.user;
        NSLog(@"User ID = %@",obj.strID);
        userSelected=customAnnotation.user;
        
    }*/
    
    //This one is most useful
    if ([view isKindOfClass:[MKAnnotationView class]]) {
        if (annotationViewController.isCallOutOpen) {
            annotationViewController.isCallOutOpen=NO;
            [annotationViewController.view removeFromSuperview];
        }else{
            NSLog(@"View Frame = %@",NSStringFromCGRect(view.frame));
             NSLog(@"View Frame Center= %@",NSStringFromCGPoint(view.center));
            ModelUser *obj=[allUser getUserForLatitude:[[view annotation] coordinate].latitude Longitude:[[view annotation] coordinate].longitude];
            userSelected=obj;
            NSLog(@"User Name = %@",obj.strUserName);
            //annotationViewController.view.frame=CGRectMake(-140, -120, 280, 100);
            [wrldMapView setCenterCoordinate:CLLocationCoordinate2DMake([[view annotation] coordinate].latitude, [[view annotation] coordinate].longitude) animated:YES];
            annotationViewController.isCallOutOpen=YES;
            annotationViewController.lblUserName.text=obj.strUserName;
            annotationViewController.lblUserCountry.text=obj.strCountryName;
            annotationViewController.view.center=CGPointMake(self.view.center.x, self.view.center.y-annotationViewController.view.frame.size.height/2-20);
            [self.view addSubview:annotationViewController.view];
            [wrldMapView setUserInteractionEnabled:NO];
            
        }
    }
    
    /*if ([view isKindOfClass:[MKAnnotationView class]]) {
        
        if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
            NSLog(@"User Location");
        }else{
            NSLog(@"Other User Location");
            
            if (annotationViewController.isCallOutOpen) {
                annotationViewController.isCallOutOpen=NO;
                [annotationViewController.view removeFromSuperview];
            }else{
                NSLog(@"View Frame = %@",NSStringFromCGRect(view.frame));
                NSLog(@"View Frame Center= %@",NSStringFromCGPoint(view.center));
                ModelUser *obj=[allUser getUserForLatitude:[[view annotation] coordinate].latitude Longitude:[[view annotation] coordinate].longitude];
                userSelected=obj;
                NSLog(@"User Name = %@",obj.strUserName);
                annotationViewController.view.frame=CGRectMake(-140, -120, 280, 100);
                [wrldMapView setCenterCoordinate:CLLocationCoordinate2DMake([[view annotation] coordinate].latitude, [[view annotation] coordinate].longitude) animated:YES];
                annotationViewController.isCallOutOpen=YES;
                annotationViewController.lblUserName.text=obj.strUserName;
                annotationViewController.lblUserCountry.text=obj.strCountryName;
                view.backgroundColor=[UIColor redColor];
                [view addSubview:annotationViewController.view];
                [wrldMapView bringSubviewToFront:view];
            }
        }
    }*/
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer
                         :(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark
#pragma mark AlertView Delegate Method
#pragma mark

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark
#pragma mark Helper Method
#pragma mark



-(void)callUpdateUserWebServiceWithPlaceMarks:(NSArray*)arrPlaceMarks
{
    if (self.isNetworkRechable) {
        CLPlacemark *placemark = [arrPlaceMarks objectAtIndex:0];
        NSDictionary *dict=[self addressDictionaryForPlaceMark:placemark];
        [[WebService service] callUpdateUserserviceWithUserName:@"" UserID:user.strID DateOfBirth:@"" Email:@"" Gender:@"" StateName:[dict objectForKey:@"State"] CountryName:[dict objectForKey:@"Country"] CityName:[dict objectForKey:@"City"] Latitude:[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude] Longitude:[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude] WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            if (isError) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something is wrong, please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag=1;
                [alert show];
            }else{
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict=(NSDictionary*)result;
                    user=[dict objectForKey:@"User"];
                    allUser=[dict objectForKey:@"AllUser"];
                    [self updateWorldMapWithWebserViceResult:allUser];
                }
            }
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

-(void)updateWorldMapWithWebserViceResult:(NSMutableArray*)arrAllUsers
{
    for (ModelUser *obj in arrAllUsers) {
        MKPointAnnotation *pointAnnonation=[[MKPointAnnotation alloc] init];
        pointAnnonation.coordinate=CLLocationCoordinate2DMake([obj.strLatitude floatValue], [obj.strLongitude floatValue]);
        [arrAnnotations addObject:pointAnnonation];
    }
    [wrldMapView addAnnotations:arrAnnotations];
    [wrldMapView reloadInputViews];
}


#pragma mark
#pragma mark AnnotationViewControllerDelegate Method
#pragma mark

-(ModelUser*)selectedUser
{
    return userSelected;
}

-(void)didAnnonationClosePressed
{
    if (annotationViewController.isCallOutOpen) {
        UIView *vw=annotationViewController.view;
        annotationViewController.isCallOutOpen=NO;
        [vw removeFromSuperview];
        [wrldMapView setUserInteractionEnabled:YES];
        [wrldMapView reloadInputViews];
    }
}

-(void)didAnnonationAttackPressedWithUser:(ModelUser *)userTapped
{
    if (annotationViewController.isCallOutOpen) {
        UIView *vw=annotationViewController.view;
        annotationViewController.isCallOutOpen=NO;
        [vw removeFromSuperview];
        [wrldMapView setUserInteractionEnabled:YES];
        [wrldMapView reloadInputViews];

    }
    NSLog(@"\n\n%@=%@\n\n",user.strID,user.strUserName);
    

    [self sendFightRequestToUser:userTapped];
    
}

//-(void)didAttackPressed
//{
//    if (annotationViewController.isCallOutOpen) {
//        annotationViewController.isCallOutOpen=NO;
//        [annotationViewController.view removeFromSuperview];
//    }
//    NSLog(@"\n\n%@=%@\n\n",user.strID,user.strUserName);
//    
//    
//    [self sendFightRequestToUser:userSelected];
//}

@end
