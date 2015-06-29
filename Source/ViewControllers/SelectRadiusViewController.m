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
#import <CoreLocation/CoreLocation.h>
#import "PrivatePublicConfirmationViewController.h"

@interface SelectRadiusViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, MKMapViewDelegate,CLLocationManagerDelegate,MKOverlay,PrivatePublicConfirmationViewControllerDelegate>
{
    IBOutlet MKMapView *mapRadious;
    
   IBOutlet UIPickerView *radiousPicker;
    NSArray *radiousArray;
    
    IBOutlet UILabel *navTitleLabel;
    IBOutlet UILabel *playeNameLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UIToolbar *radiousToolBar;
    IBOutlet UIButton *btnRadious;

    NSString *strMapRadious;
    NSString *latitude;
    NSString *longitude;
    MKPointAnnotation *annotationPoint;
    
    NSString *strSelectedRadious;

    
    CGFloat _offset;
    int distance;
    
    CLLocationManager *locManager;
    
    MKCircle *circle;
    
    PrivatePublicConfirmationViewController *confirmationController;
}

@end

@implementation SelectRadiusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    locManager=[[CLLocationManager alloc]init];
    locManager.delegate=self;
    [locManager startUpdatingLocation];
    
    // Do any additional setup after loading the view from its nib.

    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        playeNameLabel.font = [UIFont fontWithName:@"Garamond" size:19];
        addressLabel.font = [UIFont fontWithName:@"Garamond" size:15];

    }else{
        
        //  NSLog(@"iPhone6");
        navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        playeNameLabel.font = [UIFont fontWithName:@"Garamond" size:19];
        addressLabel.font = [UIFont fontWithName:@"Garamond" size:15];
    }
    radiousArray = [[NSArray alloc] initWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
   
    playeNameLabel.text=user.strUserName;
    addressLabel.text=[NSString stringWithFormat:@"%@,%@",user.strCountryName,user.strCityName];
    
    strSelectedRadious=@"5 Mile";
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locManager stopUpdatingLocation] ;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    
    NSString *strLat=[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    //NSLog(@" Latitude is %@",strLat);
    
    NSString *strLng=[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
   // NSLog(@" Longitude is %@",strLng);
    
    CLLocationCoordinate2D location;
    location.latitude=[strLat doubleValue];
    location.longitude=[strLng doubleValue];
    
    region.span=span;
    region.center=location;
    
    [mapRadious setRegion:region];
    [mapRadious regionThatFits:region];
    
    
    
    



}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    
    MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        if (!pinView)
        {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"location_icon.png"];
            pinView.calloutOffset = CGPointMake(0, 0);
        } else {
            pinView.annotation = annotation;
        }
      //  return pinView;
        
    }
    return pinView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapRadious.delegate=self ;
    [self mapViewImpliment];
}

-(void) mapViewImpliment
{
    float meter = [self getMileFromSelection]*1000*0.621;

    NSLog(@"latitude :%f",locManager.location.coordinate.latitude);
    NSLog(@"longitude :%f",locManager.location.coordinate.longitude);
    circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(locManager.location.coordinate.latitude, locManager.location.coordinate.longitude) radius:meter];
    [mapRadious addOverlay:circle];

}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithCircle:(MKCircle*)overlay];
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
    return [radiousArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"%@ Mile",[radiousArray objectAtIndex:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    strSelectedRadious=[NSString stringWithFormat:@"%@ Mile",[radiousArray objectAtIndex:row]];
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


-(NSInteger)getMileFromSelection
{
    return [[[strSelectedRadious componentsSeparatedByString:@" "] firstObject] integerValue];
}

-(IBAction)saveButtonTapped:(id)sender{
    
    [btnRadious setTitle:[NSString stringWithFormat:@"%@    ",strSelectedRadious] forState:UIControlStateNormal];
    
    radiousPicker.hidden = YES;
    radiousToolBar.hidden=YES;
    NSLog(@"Selected Radious = %ld",(long)[self getMileFromSelection]);
    
    
    float meter = (long)[self getMileFromSelection]*1000*0.621;
    [mapRadious removeOverlay:circle];
    circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(locManager.location.coordinate.latitude, locManager.location.coordinate.longitude) radius:meter];
    [mapRadious addOverlay:circle];
    
    confirmationController=[[PrivatePublicConfirmationViewController alloc] initWithNibName:@"PrivatePublicConfirmationViewController" bundle:nil];
    confirmationController.delegate=self;
    [confirmationController.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:confirmationController.view];
}

-(void)didPublicPressed
{
    NSLog(@"%s",__func__);
    [confirmationController.view removeFromSuperview];
    confirmationController=nil;
    
    [[WebService service] callCreateTournamentForCategoryId:self.tournamentCategory.strID Title:self.strTitle NoOfPlayer:self.strNoOfPlayer GoldRequired:self.strGoldRequired Playtime:self.strPlayTime Radious:[[strSelectedRadious componentsSeparatedByString:@" "] firstObject] UserID:user.strID Private:@"0" WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"SUCCESS" message:@"The game is successfully created, please select the game from the join to play the game" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            [self.navigationController popToViewController:tournamentHome animated:YES];
        }
    }];
    
}

-(void)didPrivatePressed
{
    NSLog(@"%s",__func__);
    [confirmationController.view removeFromSuperview];
    confirmationController=nil;
    
    [[WebService service] callCreateTournamentForCategoryId:self.tournamentCategory.strID Title:self.strTitle NoOfPlayer:self.strNoOfPlayer GoldRequired:self.strGoldRequired Playtime:self.strPlayTime Radious:[[strSelectedRadious componentsSeparatedByString:@" "] firstObject] UserID:user.strID Private:@"1" WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"SUCCESS" message:@"The game is successfully created, please select the game from the join to play the game" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            [self.navigationController popToViewController:tournamentHome animated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
