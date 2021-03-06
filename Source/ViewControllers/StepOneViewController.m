//
//  StepOneViewController.m
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "StepOneViewController.h"
#import "Context.h"
#import "StepTwoViewController.h"
#import "SlideOutMenuViewController.h"
#import "GuildViewController.h"
#import "Context.h"
#import "WorldMapViewController.h"


@interface StepOneViewController ()
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *helpLabel;
    IBOutlet UILabel *stepLabel;
    IBOutlet NSLayoutConstraint * contentWidth;
    IBOutlet NSLayoutConstraint * contentHeight;
    IBOutlet NSLayoutConstraint * contentTopBgHeight;
    IBOutlet NSLayoutConstraint * contentButtomBgHeight;
    IBOutlet NSLayoutConstraint * bodyTextWidth;
    IBOutlet NSLayoutConstraint * bodyTextHeight;
    IBOutlet NSLayoutConstraint * progressButConsHeight;
    IBOutlet NSLayoutConstraint * skipButtonWidth;
    IBOutlet NSLayoutConstraint * skipButtonHeight;
    IBOutlet NSLayoutConstraint * nextButtonWidth;
    IBOutlet NSLayoutConstraint * nextButtonHeight;
    IBOutlet NSLayoutConstraint * nextButtonTralingCons;
    IBOutlet NSLayoutConstraint * skipButtonLead;
    IBOutlet NSLayoutConstraint * titleLabelLead;
    IBOutlet NSLayoutConstraint * titleLabelTop;
    IBOutlet NSLayoutConstraint * progressWidthCons;

}

@end

@implementation StepOneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:14];
    //self.helpLabel.font = [UIFont fontWithName:@"Garamond" size:16];
  
    if (IsIphone6 ) {
        contentWidth.constant = 315;
        contentHeight.constant = 542;
        bodyTextWidth.constant = 272;
        bodyTextHeight.constant = 300;
        titleLabelLead.constant = 20;
        titleLabelTop.constant = 29;
        helpLabel.font = [UIFont fontWithName:@"Garamond" size:18];
        stepLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:23];
        titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:15];


        contentTopBgHeight.constant = 71;
        contentButtomBgHeight.constant = 71;
        progressButConsHeight.constant = 17;
        progressWidthCons.constant = 280;
        
        skipButtonWidth.constant = 131;
        skipButtonHeight.constant = 42;
        skipButtonLead.constant = 18;
        
        nextButtonWidth.constant = 131;
        nextButtonHeight.constant = 42;
        nextButtonTralingCons.constant = 18;

    }
    else if (IsIphone6Plus )
    {
        contentWidth.constant = 348;
        contentHeight.constant = 598;
        bodyTextWidth.constant = 300;
        bodyTextHeight.constant = 331;
        titleLabelLead.constant = 22;
        titleLabelTop.constant = 32;
        helpLabel.font = [UIFont fontWithName:@"Garamond" size:20];
        stepLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:25];
        titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:17];
        
        
        contentTopBgHeight.constant = 78;
        contentButtomBgHeight.constant = 78;
        progressButConsHeight.constant = 19;
        progressWidthCons.constant = 309;
        
        skipButtonWidth.constant = 145;
        skipButtonHeight.constant = 46;
        skipButtonLead.constant = 20;
        
        nextButtonWidth.constant = 145;
        nextButtonHeight.constant = 46;
        nextButtonTralingCons.constant = 20;
    }
    else{
        helpLabel.font = [UIFont fontWithName:@"Garamond" size:14];
    }
}
-(IBAction)nextButtonTapped:(id)sender{
    StepTwoViewController *master  = [[StepTwoViewController alloc] initWithNibName:@"StepTwoViewController" bundle:nil];
    [self.navigationController pushViewController:master animated:NO];
}
-(IBAction)skipButtonTapped:(id)sender{
    /*GuildViewController *master  = [[GuildViewController alloc] initWithNibName:@"GuildViewController" bundle:nil];*/
    WorldMapViewController *master=[[WorldMapViewController alloc] initWithNibName:@"WorldMapViewController" bundle:nil];
    master.isCalledFromTournament=NO;
    master.strTournamentID=@"";
    [self.navigationController pushViewController:master animated:NO];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButtonTapped:(id)sender{
    //[self.navigationController popViewControllerAnimated:YES];
}

@end
