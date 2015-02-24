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


#define MileConversionParameter 0.621371192

NSUserDefaults *pref;

@interface WorldMapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    
    IBOutlet MKMapView *wrldMapView;

    CGFloat _offset;
    CGFloat distancePerMile;
    CLLocationManager *locationManager;
    
    
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
    distancePerMile = 5.0*MileConversionParameter*1000;
    
    //wrldMapView.delegate=nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(locationManager==nil)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
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
             span.latitudeDelta = miles/69.0;
             span.longitudeDelta = miles/(scalingFactor * 69.0);
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
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"location_icon.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
        
    }
    
    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//        // Try to dequeue an existing pin view first.
//        if (!pinView)
//        {
//            // If an existing pin view was not available, create one.
//            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
//            //pinView.animatesDrop = YES;
//            pinView.canShowCallout = YES;
//            pinView.image = [UIImage imageNamed:@"pin.png"];
//            pinView.calloutOffset = CGPointMake(0, 32);
//        } else {
//            pinView.annotation = annotation;
//        }
//        return pinView;
//    }
    return nil;
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
            }
        }
    }];
}

-(void)updateWorldMapWithWebserViceResult
{
    
}


#pragma mark
#pragma mark IBAction Method
#pragma mark



@end
