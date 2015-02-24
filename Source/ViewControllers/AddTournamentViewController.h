//
//  AddTournamentViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface AddTournamentViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UILabel *navTitleLabel;
@property (nonatomic, strong) IBOutlet UIButton *noOfPlayerCanPlayButton;
@property (nonatomic, strong) IBOutlet UIButton *goldRequiredButton;
@property (nonatomic, strong) IBOutlet UIButton *rankingButton;
@property (nonatomic, strong) IBOutlet UIButton *playTimeButton;
@property (nonatomic, strong) IBOutlet UIButton *radiusButton;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField;

-(IBAction)backButtonTapped:(id)sender;
-(IBAction)noOfPlayerCanPlayButtonTapped:(id)sender;
-(IBAction)goldRequiredButtonTapped:(id)sender;
-(IBAction)rankingButtonTapped:(id)sender;
-(IBAction)playTimeButtonTapped:(id)sender;
-(IBAction)radiusButtonTapped:(id)sender;
-(IBAction)slideMenuButtonTapped:(id)sender;
@end
