//
//  SelectRadiusViewController.m
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "SelectRadiusViewController.h"
#import "Context.h"
#import "SlideOutMenuViewController.h"
#import "AddTournamentViewController.h"
#import "AppDelegate.h"
#import "DataClass.h"
NSUserDefaults *pref;

@interface SelectRadiusViewController ()
{
    CGFloat _offset;
    int distance;
}

@property (nonatomic, strong) NSString *mapRadious;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) MKCircle *circle;
@property (nonatomic, strong) MKPointAnnotation *annotationPoint;
@end

@implementation SelectRadiusViewController
@synthesize navTitleLabel, playeNameLabel, addressLabel, radiousButton, radiousArray, radiousPicker, radiousToolBar, radiousMapView, mapRadious, circle, annotationPoint, latitude, longitude;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;
    pref = [NSUserDefaults standardUserDefaults];

    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        self.playeNameLabel.font = [UIFont fontWithName:@"Garamond" size:19];
        self.addressLabel.font = [UIFont fontWithName:@"Garamond" size:15];
        self.radiousButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:18];

    }else{
        
        //  NSLog(@"iPhone6");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        self.playeNameLabel.font = [UIFont fontWithName:@"Garamond" size:19];
        self.addressLabel.font = [UIFont fontWithName:@"Garamond" size:15];
        self.radiousButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:21];
        
    }
    mapRadious = [pref valueForKey:@"MapRadious"];
    self.radiousArray = [[NSArray alloc] initWithObjects:@"1 Mile", @"2 Mile",@"3 Mile",@"4 Mile",@"5 Mile",@"6 Mile",@"7 Mile",@"8 Mile",@"9 Mile",@"10 Mile", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self mapViewImpliment];
}
-(void) mapViewImpliment{
    
//    AppDelegate *appDg =(AppDelegate *) [[UIApplication sharedApplication] delegate];
//    appDg.locManager=nil;
//    [appDg localnotification];
//    
//    //Map CoordinateRegion
//    MKCoordinateRegion region;
//    region.center.latitude = appDg.locManager.location.coordinate.latitude;
//    region.center.longitude = appDg.locManager.location.coordinate.longitude;
//    
//    latitude = [NSNumber numberWithFloat:region.center.latitude].stringValue;
//    longitude = [NSNumber numberWithFloat:region.center.longitude].stringValue;
//    
//    //one degree of latitude is always approximately 111 kilometers (69 miles).
// 
//    double scalingFactor = ABS((cos(2 * M_PI * region.center.latitude / 360.0) ));
//    
//    NSLog(@"Scaling factor %f",scalingFactor);
//    //distance = [mapRadious intValue];
//    distance = appDg.selectedRadious;
//
//    NSLog(@"Distance %d", distance);
//    
//    MKCoordinateSpan span;
//    span.latitudeDelta = 5/14.0;
//    span.longitudeDelta = 5/(scalingFactor * 14.0);
//    region.span = span;
//    // 1 km = 1000m, 1mile = 1.60934 km
//    int meter = distance*1000*1.60934;
//    NSLog(@"Radious meter %d", meter);
//    circle= [[MKCircle alloc]init];
//    circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(appDg.locManager.location.coordinate.latitude,appDg.locManager.location.coordinate.longitude) radius:meter];
//    
//    [radiousMapView addOverlay:circle];
//
//    
//    [radiousMapView regionThatFits:region ];
//    [radiousMapView setRegion:region animated:YES];
//    
//    //Make Annotation pin
//    CLLocationCoordinate2D annotationCoord;
//    
//    for (NSDictionary *users in appDg.nearByUserArray) {
//        annotationPoint=[[MKPointAnnotation alloc] init] ;
//        
//        annotationCoord.latitude =[[users objectForKey:@"lat" ] doubleValue];
//        annotationCoord.longitude = [[users objectForKey:@"lon" ] doubleValue];
//        annotationPoint.coordinate = annotationCoord;
//        annotationPoint.title = [users objectForKey:@"user_name" ];
//        annotationPoint.subtitle = [NSString stringWithFormat:@"%@ %@",[users objectForKey:@"country_id"],[users objectForKey:@"city_id"]];
//        [radiousMapView addAnnotation:annotationPoint];
//        
//    }
    
}

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



-(IBAction)radiousButtonTapped:(id)sender{
    radiousPicker.hidden = NO;
    radiousToolBar.hidden = NO;
}

# pragma mark PickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.radiousArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title;
    title=[self.radiousArray objectAtIndex:row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str = [self.radiousArray objectAtIndex:row];
    
    
    [str componentsSeparatedByString:@"Mile"];
    self.radiousButton.titleLabel.text = [self.radiousArray objectAtIndex:row];
    NSLog(@"Radious = %@", [str substringToIndex:2]);
    
    mapRadious =[str substringToIndex:2];
    
    
    
}
- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

-(IBAction)saveButtonTapped:(id)sender{
    //appDg.selectedRadious = [mapRadious integerValue];

    radiousPicker.hidden = YES;
    radiousToolBar.hidden = YES;
    //[pref setValue:mapRadious forKey:@"MapRadious"];
    //[self fetchUsersFromServer];
    DataClass *commonData = [[DataClass alloc] init];
    commonData.isApiCalled=3;
    [pref setInteger:1 forKey:@"LoggedInState"];
    
    
    NSDictionary *params = @{@"lat" :latitude,
                             @"lon" : longitude,
                             @"redius" : mapRadious};
    NSLog(@"Parama = %@", params);
    
    [commonData apiCall:params method:@"POST" completionHandler:^(id response, NSError *error)
     {
         if (error)
         {
             NSLog(@"API Error : %@", error);
         }
         
         else
         {
             NSLog(@"API Response : %@", response);
             int status =[[response valueForKey:@"status"] intValue];
             
             if (status==1)
             {
                 [self alertStatus:@"Select Radious Successful." :nil];
                 
                 
             }
             else
             {
                 
                 UIAlertView *alert = [[UIAlertView alloc]
                                       initWithTitle:@" Failed!"
                                       message:@"Please try again."
                                       delegate:self
                                       cancelButtonTitle:@"Ok"
                                       otherButtonTitles:nil];
                 [alert show];
             }
         }
         
     }];

    [radiousMapView removeOverlay:circle];
    [radiousMapView removeAnnotation:annotationPoint];

    [self mapViewImpliment];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
