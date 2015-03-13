//
//  SettingsViewController.m
//  Chosen
//
//  Created by appsbee on 19/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SettingsViewController.h"
#import "SlideOutMenuViewController.h"
#import "Context.h"
#import "UpdateProfileViewController.h"
#import "AboutUsViewController.h"
#import "MyProfileViewController.h"

@interface SettingsViewController (){
    CGFloat _offset;

}
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentViewWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentViewHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * profileSetWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * profileSetHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * abtWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * abtHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * abtTopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * priPolWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * priPolHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * priPolTopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * trmUseWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * trmUseHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * trmUsetopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentViewCenterConst;

@property (nonatomic, strong) IBOutlet UIButton *proSetButton;
@property (nonatomic, strong) IBOutlet UIButton *abtButton;
@property (nonatomic, strong) IBOutlet UIButton *priPoliButton;
@property (nonatomic, strong) IBOutlet UIButton *termsOfUseButton;


@end

@implementation SettingsViewController
@synthesize abtButton, priPoliButton, termsOfUseButton;
@synthesize contentViewHeightConst, contentViewWidthConst, profileSetHeightConst, profileSetWidthConst, abtHeightConst, abtWidthConst, abtTopConst, priPolHeightConst, priPolWidthConst, priPolTopConst, trmUseHeightConst, trmUseWidthConst, trmUsetopConst,contentViewCenterConst;


#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;
    if (IsIphone5) {
        contentViewHeightConst.constant = 428;
        contentViewCenterConst.constant=-50;

        abtTopConst.constant = 26;
        priPolTopConst.constant = 26;
        trmUsetopConst.constant = 26;
                
    }else if(IsIphone6){
        contentViewCenterConst.constant=-20;
        contentViewHeightConst.constant = 503;
        contentViewWidthConst.constant = 331;
        profileSetWidthConst.constant = 331;
        profileSetHeightConst.constant = 102;
        abtWidthConst.constant = 331;
        abtHeightConst.constant = 102;
        priPolWidthConst.constant = 331;
        priPolHeightConst.constant = 102;
        trmUseWidthConst.constant = 331;
        trmUseHeightConst.constant = 102;

        abtTopConst.constant = 36;
        priPolTopConst.constant = 36;
        trmUsetopConst.constant = 36;
    }else if (IsIphone6Plus){
        contentViewCenterConst.constant=-75;

        contentViewHeightConst.constant = 655;
        contentViewWidthConst.constant = 366;
        
        profileSetWidthConst.constant = 366;
        profileSetHeightConst.constant = 113;
        abtWidthConst.constant = 113;
        abtHeightConst.constant = 102;
        priPolWidthConst.constant = 366;
        priPolHeightConst.constant = 113;
        trmUseWidthConst.constant = 366;
        trmUseHeightConst.constant = 113;
        abtTopConst.constant = 40;
        priPolTopConst.constant = 40;
        trmUsetopConst.constant = 40;
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark IBAction Method
#pragma mark


-(IBAction)setMenuButtonTapped:(id)sender{
    
    self.proSetButton.selected = YES;
    self.abtButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = NO;
    if (self.isNetworkRechable) {
        MyProfileViewController *master=[[MyProfileViewController alloc] initWithNibName:@"MyProfileViewController" bundle:nil];
        [self.navigationController pushViewController:master animated:YES];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
-(IBAction)abtButtonTapped:(id)sender{
    self.proSetButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = NO;
    self.abtButton.selected = YES;
    if (self.isNetworkRechable) {
        AboutUsViewController *master=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
        master.strFor=@"aboutus";
        [self.navigationController pushViewController:master animated:YES];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
-(IBAction)priPolButtonTapped:(id)sender{
    self.proSetButton.selected = NO;
    self.priPoliButton.selected = YES;
    self.termsOfUseButton.selected = NO;
    self.abtButton.selected = NO;
    if (self.isNetworkRechable) {
        AboutUsViewController *master=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
        master.strFor=@"privacy";
        [self.navigationController pushViewController:master animated:YES];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}
-(IBAction)trmUseBtnTapped:(id)sender{
    self.proSetButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = YES;
    self.abtButton.selected = NO;
    if (self.isNetworkRechable) {
        AboutUsViewController *master=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
        master.strFor=@"terms";
        [self.navigationController pushViewController:master animated:YES];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}

@end
