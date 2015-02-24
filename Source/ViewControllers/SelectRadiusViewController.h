//
//  SelectRadiusViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectRadiusViewController : BaseViewController<UIPickerViewDataSource, UIPickerViewDelegate, MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *radiousMapView;

@property (nonatomic, strong)IBOutlet UIPickerView *radiousPicker;
@property (nonatomic, strong) NSArray *radiousArray;

@property (nonatomic, strong) IBOutlet UILabel *navTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *playeNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UIButton *radiousButton;
@property (nonatomic, strong) IBOutlet UIToolbar *radiousToolBar;
-(IBAction)slideMenuButtonTapped:(id)sender;
-(IBAction)backButtonTapped:(id)sender;
-(IBAction)saveButtonTapped:(id)sender;
-(IBAction)radiousButtonTapped:(id)sender;

@end
