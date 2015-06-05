//
//  SlideOutMenuViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SlideOutMenuViewController.h"
#import "SlideMenuTableViewCell.h"

#import "WorldMapViewController.h"
#import "GuildViewController.h"
#import "SettingsViewController.h"
#import "TournamentHomeViewController.h"

#import "ContractViewController.h"


NSString static *arrImages[]={
    [0]=@"world_map_icon.png",
    [1]=@"guild_icon.png",
    [2]=@"contract_icon.png",
    [3]=@"tournameny_icon.png",
    [4]=@"settings_icon.png",
};

NSString static *arrSelectionImages[]={
    [0]=@"menu_button_1.png",
    [1]=@"menu_button_2.png",
};

NSString static *arrContentText[]={
    [0]=@"WORLD MAP",
    [1]=@"GUILD",
    [2]=@"CONTRACT",
    [3]=@"TOURNAMENT",
    [4]=@"SETTINGS",
};

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
    
    NSIndexPath *indexPathSelected;
    NSMutableArray *arrAllIndexPath;
}

@end

@implementation SlideOutMenuViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrAllIndexPath=[[NSMutableArray alloc] init];
    
    guildButton.selected = NO;
    pref = [NSUserDefaults standardUserDefaults];


    // Do any additional setup after loading the view from its nib.
    trainingTimeLeftLabel.font = [UIFont fontWithName:@"Garamond" size:11];
    trainingTimeLeftValueLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    lastBatttleLabel.font = [UIFont fontWithName:@"Garamond" size:12];
    lastBatttValueleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    
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
    return 5;
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
    
    if (indexPathSelected==indexPath) {
        cell.imgBackGround.image=[UIImage imageNamed:arrSelectionImages[1]];
    }else{
        cell.imgBackGround.image=[UIImage imageNamed:arrSelectionImages[0]];
    }
    
    cell.imgIcon.image=[UIImage imageNamed:arrImages[indexPath.row]];
    cell.lblText.text=arrContentText[indexPath.row];
    
    
    if (___isIphone4_4s) {
        cell.consImageHeight.constant=25.0f;
    }
    else if (___isIphone5_5s){
        cell.consImageHeight.constant=30.0f;
    }
    else if (___isIphone6){
        cell.consImageHeight.constant=38.0f;
    }
    else if (___isIphone6Plus){
        cell.consImageHeight.constant=40.0f;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexPathSelected=indexPath;
    [tableView reloadData];
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
