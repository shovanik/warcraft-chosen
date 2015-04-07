//
//  SlideOutMenuViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SlideOutMenuViewController.h"
#import "SlideMenuTableViewCell.h"
#import "STTwitter.h"

#import "WorldMapViewController.h"
#import "GuildViewController.h"
#import "SettingsViewController.h"
#import "TournamentHomeViewController.h"

#import "ContractViewController.h"

NSUserDefaults *pref;
@interface SlideOutMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *trainingTimeLeftLabel;
    IBOutlet UILabel *trainingTimeLeftValueLabel;
    IBOutlet UILabel *lastBatttleLabel;
    IBOutlet UILabel *lastBatttValueleLabel;
    IBOutlet UIButton *worldButton;
    IBOutlet UIButton *guildButton;
    IBOutlet UIButton *contractButton;
    IBOutlet UIButton *tournamentButton;
    IBOutlet UIButton *settingsButton;
    IBOutlet UITableView *menuTableview;
    
    NSMutableArray *arrImage;

}

@end

@implementation SlideOutMenuViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    guildButton.selected = NO;
    pref = [NSUserDefaults standardUserDefaults];


    // Do any additional setup after loading the view from its nib.
    trainingTimeLeftLabel.font = [UIFont fontWithName:@"Garamond" size:11];
    trainingTimeLeftValueLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    lastBatttleLabel.font = [UIFont fontWithName:@"Garamond" size:12];
    lastBatttValueleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    
    arrImage=[[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"smenu_map_normal_iphn6@2x.png"],[UIImage imageNamed:@"smenu_guild_normal_iphn6@2x.png"],[UIImage imageNamed:@"smenu_contract_normal_iph6@2x.png"],[UIImage imageNamed:@"smenu_tournament_normal_iphn6@2x.png"],[UIImage imageNamed:@"smenu_settings_normal_iphn6@2x.png"], nil];
    NSLog(@"arrImage count = %ld",(unsigned long)arrImage.count);
    
    
    if (___isIphone4_4s) {
        NSLog(@"iPhone4");
    }
    else if (___isIphone5_5s){
        NSLog(@"iPhone5");
    }
    else if (___isIphone6){
        NSLog(@"iPhone6");
    }
    else if (___isIphone6Plus){
        NSLog(@"iPhone 6 Plus");
    }
    
    
    [menuTableview reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (IBAction)logoutButtonTapped:(id)sender {
    
}


#pragma mark
#pragma mark UITableViewDelegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrImage.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0.0f;
    if (___isIphone4_4s) {
        height=58.0f;
    }
    else if (___isIphone5_5s){
        height=75.0f;
    }
    else if (___isIphone6){
        height=96.0f;
    }
    else if (___isIphone6Plus){
        height=108.0f;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"MyCell";
    SlideMenuTableViewCell *cell=(SlideMenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SlideMenuTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    //[cell.btn setBackgroundImage:[arrImage objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    cell.imgBackGround.image=[arrImage objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self btnWorldMapClicked];
            break;
        case 1:
            [self btnGuildClicked];
            break;
        case 2:
            [self btnContractClicked];
            break;
        case 3:
            [self btnTournamentClicked];
            break;
        case 4:
            [self btnSettingsClicked];
            break;
        default:
            break;
    }
}

#pragma mark
#pragma mark Delegate Implemantation Methods
#pragma mark

-(void)btnWorldMapClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didWorlMapClicked)]) {
        [self.delegate didWorlMapClicked];
        
        if ([self.delegate isKindOfClass:[BaseViewController class]]) {
            BaseViewController *base=(BaseViewController*)self.delegate;
            WorldMapViewController *master=[[WorldMapViewController alloc] initWithNibName:@"WorldMapViewController" bundle:nil];
            [base.navigationController pushViewController:master animated:YES];
        }
        
    }
}
-(void)btnGuildClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didGuildClicked)]) {
        [self.delegate didGuildClicked];
        
        if ([self.delegate isKindOfClass:[BaseViewController class]]) {
            BaseViewController *base=(BaseViewController*)self.delegate;
            GuildViewController *master=[[GuildViewController alloc] initWithNibName:@"GuildViewController" bundle:nil];
            [base.navigationController pushViewController:master animated:YES];
        }
    }
}
-(void)btnContractClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didContractClicked)]) {
        [self.delegate didContractClicked];
        
        if ([self.delegate isKindOfClass:[BaseViewController class]]) {
            BaseViewController *base=(BaseViewController*)self.delegate;
            ContractViewController *master=[[ContractViewController alloc] initWithNibName:@"ContractViewController" bundle:nil];
            [base.navigationController pushViewController:master animated:YES];
        }
    }
}
-(void)btnTournamentClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTournamentClicked)]) {
        [self.delegate didTournamentClicked];
        
        if ([self.delegate isKindOfClass:[BaseViewController class]]) {
            BaseViewController *base=(BaseViewController*)self.delegate;
            TournamentHomeViewController *master=[[TournamentHomeViewController alloc] initWithNibName:@"TournamentHomeViewController" bundle:nil];
            [base.navigationController pushViewController:master animated:YES];
        }
    }
}
-(void)btnSettingsClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSettingsClicked)]) {
        [self.delegate didSettingsClicked];
        
        if ([self.delegate isKindOfClass:[BaseViewController class]]) {
            BaseViewController *base=(BaseViewController*)self.delegate;
            SettingsViewController *master=[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
            [base.navigationController pushViewController:master animated:YES];
        }
    }
}



@end
