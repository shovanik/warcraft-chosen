//
//  AddTournamentViewController.m
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AddTournamentViewController.h"
#import "TournamentDetailsViewController.h"
#import "Context.h"
#import "SlideOutMenuViewController.h"
#import "SelectRadiusViewController.h"


@interface AddTournamentViewController (){
    CGFloat _offset;
}

@end

@implementation AddTournamentViewController
@synthesize navTitleLabel, titleTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;

    
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        self.noOfPlayerCanPlayButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.goldRequiredButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.rankingButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.playTimeButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.radiusButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.titleTextField.font = [UIFont fontWithName:@"Garamond" size:13];
        
    }else{
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        self.noOfPlayerCanPlayButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.goldRequiredButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.rankingButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.playTimeButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.radiusButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
        self.titleTextField.font = [UIFont fontWithName:@"Garamond" size:13];

        //  NSLog(@"iPhone6");
        
    }

}
-(IBAction)slideMenuButtonTapped:(id)sender{
    SlideOutMenuViewController *mVC = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController_iPhone4" bundle:nil ];
    }else{
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController" bundle:nil ];
        
    }
    //mVC.guildButton.selected = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButtonTapped:(id)sender{
    TournamentDetailsViewController *tdVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        tdVC = [[TournamentDetailsViewController alloc] initWithNibName:@"TournamentDetailsViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        tdVC =  [[TournamentDetailsViewController alloc] initWithNibName:@"TournamentDetailsViewController" bundle:nil];
        
        //  NSLog(@"iPhone6");
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)noOfPlayerCanPlayButtonTapped:(id)sender{
    
}

-(IBAction)radiusButtonTapped:(id)sender{
    SelectRadiusViewController *tdVC  = [[SelectRadiusViewController alloc] initWithNibName:@"SelectRadiusViewController" bundle:nil];
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
