//
//  TournamentViewController.m
//  Chosen
//
//  Created by appsbee on 23/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "TournamentViewController.h"
#import "SlideOutMenuViewController.h"
#import "TournamentDetailsViewController.h"
#import "GuildViewController.h"
#import "Context.h"

@interface TournamentViewController (){
    CGFloat _offset;

}

@end

@implementation TournamentViewController
@synthesize mostWinLabel, kingofTheHillsLabel, lastManStandingLabel, navTitleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;
    self.mostWinLabel.font = [UIFont fontWithName:@"Garamond" size:16];
    self.kingofTheHillsLabel.font = [UIFont fontWithName:@"Garamond" size:16];
    self.lastManStandingLabel.font = [UIFont fontWithName:@"Garamond" size:16];
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        
    }else{
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        
        //  NSLog(@"iPhone6");
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(IBAction)tournamentButtonTapped:(id)sender
{
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
