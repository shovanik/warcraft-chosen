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
#import "ImageViewGuild.h"

typedef NS_ENUM(NSUInteger, SidePanelContent) {
    WorldMap=0,
    Guild,
    Tournament,
    Settings,
    LogOut,
    Total,
};


NSString static *arrImages[]={
    [WorldMap]=@"world_map_icon.png",
    [Guild]=@"guild_icon.png",
    [Tournament]=@"tournameny_icon.png",
    [Settings]=@"settings_icon.png",
    [LogOut]=@"logout_icon.png",
};

NSString static *arrSelectionImages[]={
    [0]=@"menu_button_1.png",
    [1]=@"menu_button_2.png",
};

NSString static *arrContentText[]={
    [WorldMap]=@"WORLD MAP",
    [Guild]=@"GUILD",
    [Tournament]=@"TOURNAMENT",
    [Settings]=@"SETTINGS",
    [LogOut]=@"Log Out",
};

NSUserDefaults *pref;
@interface SlideOutMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *trainingTimeLeftLabel;
    IBOutlet UILabel *lastBatttleLabel;
    IBOutlet UITableView *menuTableview;
    IBOutlet ImageViewGuild *imgAvtar;
    IBOutlet UIView *vwLastBattle;
    
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
    
    indexPathSelected=[NSIndexPath indexPathForRow:0 inSection:0];
    
    arrAllIndexPath=[[NSMutableArray alloc] init];
    
    pref = [NSUserDefaults standardUserDefaults];
    [menuTableview reloadData];
    
    vwLastBattle.layer.borderColor=[UIColor colorWithRed:44.0f/255.0f green:50.0f/255.0f blue:54.0f/255.0f alpha:1.0].CGColor;
}

-(void)setAvtarImageForURL:(NSURL*)urlImg
{
    [imgAvtar setImageFromURL:urlImg.absoluteString];
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
    return Total;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0.0f;
    if (___isIphone4_4s) {
        height=70.0f;
    }
    else if (___isIphone5_5s){
        height=88.0f;
    }
    else if (___isIphone6){
        height=104.0f;
    }
    else if (___isIphone6Plus){
        height=117.0f;
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
    
    if (indexPath.row==Total-1) {
        cell.imgBackGround.backgroundColor=[UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:22.0f/255.0f alpha:1.0];
    }else{
        if (indexPathSelected.row==indexPath.row) {
            cell.imgBackGround.image=[UIImage imageNamed:arrSelectionImages[1]];
        }else{
            cell.imgBackGround.image=[UIImage imageNamed:arrSelectionImages[0]];
        }
    }
    cell.imgIcon.image=[UIImage imageNamed:arrImages[indexPath.row]];
    cell.lblText.text=[arrContentText[indexPath.row] uppercaseString];
    
    
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
        case WorldMap:
            [self btnWorldMapClicked];
            break;
        case Guild:
            [self btnGuildClicked];
            break;
        /*case 2:
            [self btnContractClicked];
            break;*/
        case Tournament:
            [self btnTournamentClicked];
            break;
        case Settings:
            [self btnSettingsClicked];
            break;
        case LogOut:
            [self btnLogoutClicked];
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
-(void)btnLogoutClicked
{
    if (self.delegate) {
        BaseViewController *base=(BaseViewController*)self.delegate;
        [base.navigationController popToRootViewControllerAnimated:YES];
        [base disconnectSocket];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didLogoutTapped)]) {
            [self.delegate didLogoutTapped];
        }
    }
}


@end
