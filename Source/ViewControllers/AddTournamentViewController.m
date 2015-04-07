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
#import "AddTournamentTableViewCell.h"


@interface AddTournamentViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _offset;
    IBOutlet UITableView *tblAddTournament;
    
    BOOL isAnyDropDownOpen;
    
    UITableView *tblPlayer;
    UITableView *tblGold;
    UITableView *tblRanking;
    UITableView *tblPlayTime;
    
    BOOL isPlayerOpen;
    BOOL isGoldOpen;
    BOOL isRankingOpen;
    BOOL isPlayTimeOpen;
    
    
    NSString *strNoOfPlayer;
    NSString *strGoldRequired;
    NSString *strRanking;
    NSString *strPlayTime;
}

@end

@implementation AddTournamentViewController
@synthesize tournamentCategory;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [tblAddTournament reloadData];
    
    _offset = 50;
    
    tblAddTournament.backgroundColor = [UIColor clearColor];
    
    isPlayerOpen=isGoldOpen=isRankingOpen=isPlayTimeOpen=NO;
    strNoOfPlayer=strGoldRequired=strRanking=strPlayTime=@"";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)radiusButtonTapped:(id)sender{
    SelectRadiusViewController *tdVC  = [[SelectRadiusViewController alloc] initWithNibName:@"SelectRadiusViewController" bundle:nil];
    [self.navigationController pushViewController:tdVC animated:YES];
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
    if (tableView==tblAddTournament) {
        return 6;
    }
    else if (tableView==tblPlayer){
        return 10;
    }
    else if (tableView==tblGold){
        return 10;
    }
    else if (tableView==tblRanking){
        return 5;
    }
    else if (tableView==tblPlayTime){
        return 15;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tblAddTournament) {
        if (IsIphone4) {
            return 48.0f;
        }else if (IsIphone5) {
            return 63.0f;
            
        }else if (IsIphone6) {
            return 80.0f;
        }
        else if(IsIphone6Plus){
            return 90.0f;
        }
    }else{
        return 30.0f;
    }
    return 0;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentfire = @"Cell";
    UITableViewCell *myCell=nil;
    
    if (tableView==tblAddTournament) {
        AddTournamentTableViewCell *cell = (AddTournamentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentfire];
        if (cell == nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"AddTournamentTableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row == 0) {
            cell.imgBackground.image = [UIImage imageNamed:@"addTrm_dropdown_titlebox_iphn4"];
            cell.labelTitle.text = @"Title";
            cell.textFieldTitle.hidden = NO;
            cell.imgArrow.hidden = YES;
            cell.labelTitle.hidden = YES;
            cell.labelSelectedValue.hidden=YES;
            cell.btnSelect.hidden=YES;
            cell.vwDropDown.hidden=YES;
        }
        else if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] -1){
            cell.labelTitle.text = @"Radious";
            cell.btnSelect.hidden = NO;
            cell.imgArrow.hidden = YES;
            cell.labelSelectedValue.hidden=YES;
            cell.vwDropDown.hidden=YES;
        }else{
            [cell.btnSelect setBackgroundColor:[UIColor clearColor]];
            [cell.btnSelect setTitle:@"" forState:UIControlStateNormal];
        }
        
        
        switch (indexPath.row) {
            case 1:
                cell.labelTitle.text=@"No. of Player";
                cell.labelSelectedValue.text=strNoOfPlayer;
                break;
            case 2:
                cell.labelTitle.text=@"Gold Required";
                cell.labelSelectedValue.text=strGoldRequired;
                break;
            case 3:
                cell.labelTitle.text=@"Ranking";
                cell.labelSelectedValue.text=strRanking;
                break;
            case 4:
                cell.labelTitle.text=@"Play Time";
                cell.labelSelectedValue.text=strPlayTime;
                break;
            default:
                break;
        }
        
        
        cell.btnSelect.tag=indexPath.row;
        [cell.btnSelect addTarget:self action:@selector(btnSelectPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
        myCell=cell;
    }
    else if (tableView==tblPlayer){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentfire];
        cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        myCell=cell;
    }
    else if (tableView==tblGold){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentfire];
        cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row*100];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        myCell=cell;
    }
    else if (tableView==tblRanking){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentfire];
        cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        myCell=cell;
    }
    else if (tableView==tblPlayTime){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentfire];
        cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        myCell=cell;
    }
    
    return myCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tblPlayer){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
        AddTournamentTableViewCell *cell=(AddTournamentTableViewCell*)[tblAddTournament cellForRowAtIndexPath:indexPath];
        cell.labelSelectedValue.text=[NSString stringWithFormat:@"%ld",indexPath.row];
        strNoOfPlayer=[NSString stringWithFormat:@"%ld",indexPath.row];
    }
    else if (tableView==tblGold){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
        AddTournamentTableViewCell *cell=(AddTournamentTableViewCell*)[tblAddTournament cellForRowAtIndexPath:indexPath];
        cell.labelSelectedValue.text=[NSString stringWithFormat:@"%ld",indexPath.row*100];
        strGoldRequired=[NSString stringWithFormat:@"%ld",indexPath.row*100];
    }
    else if (tableView==tblRanking){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
        AddTournamentTableViewCell *cell=(AddTournamentTableViewCell*)[tblAddTournament cellForRowAtIndexPath:indexPath];
        cell.labelSelectedValue.text=[NSString stringWithFormat:@"%ld",indexPath.row];
        strRanking=[NSString stringWithFormat:@"%ld",indexPath.row];
    }
    else if (tableView==tblPlayTime){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
        AddTournamentTableViewCell *cell=(AddTournamentTableViewCell*)[tblAddTournament cellForRowAtIndexPath:indexPath];
        cell.labelSelectedValue.text=[NSString stringWithFormat:@"%ld",indexPath.row];
        strPlayTime=[NSString stringWithFormat:@"%ld",indexPath.row];
    }
}

-(void)btnSelectPressed:(id)sender
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[sender tag] inSection:0];
    AddTournamentTableViewCell *cell=(AddTournamentTableViewCell*)[tblAddTournament cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row==1)
    {
        if (isPlayerOpen) {
            [tblPlayer removeFromSuperview];
            tblPlayer=nil;
            isPlayerOpen=NO;
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI*2);
            }];
        }else{
            tblPlayer=[[UITableView alloc] initWithFrame:CGRectMake(cell.labelSelectedValue.frame.origin.x, cell.frame.origin.y+cell.labelSelectedValue.frame.origin.y+cell.labelSelectedValue.frame.size.height+1, cell.labelSelectedValue.frame.size.width, 100) style:UITableViewStylePlain];
            tblPlayer.separatorStyle=UITableViewCellSeparatorStyleNone;
            tblPlayer.delegate=self;
            tblPlayer.dataSource=self;
            [tblAddTournament addSubview:tblPlayer];
            isPlayerOpen=YES;
            tblPlayer.backgroundColor=[UIColor colorWithRed:3.0f/255.0f green:41.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI);
            }];
        }
    }
    else if (indexPath.row==2)
    {
        if (isGoldOpen) {
            [tblGold removeFromSuperview];
            tblGold=nil;
            isGoldOpen=NO;
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI*2);
            }];
        }else{
            tblGold=[[UITableView alloc] initWithFrame:CGRectMake(cell.labelSelectedValue.frame.origin.x, cell.frame.origin.y+cell.labelSelectedValue.frame.origin.y+cell.labelSelectedValue.frame.size.height+1, cell.labelSelectedValue.frame.size.width, 100) style:UITableViewStylePlain];
            tblGold.separatorStyle=UITableViewCellSeparatorStyleNone;
            tblGold.delegate=self;
            tblGold.dataSource=self;
            [tblAddTournament addSubview:tblGold];
            isGoldOpen=YES;
            
            tblGold.backgroundColor=[UIColor colorWithRed:3.0f/255.0f green:41.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI);
            }];
        }
    }
    else if (indexPath.row==3)
    {
        if (isRankingOpen) {
            [tblRanking removeFromSuperview];
            tblRanking=nil;
            isRankingOpen=NO;
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI*2);
            }];
        }else{
            tblRanking=[[UITableView alloc] initWithFrame:CGRectMake(cell.labelSelectedValue.frame.origin.x, cell.frame.origin.y+cell.labelSelectedValue.frame.origin.y+cell.labelSelectedValue.frame.size.height+1, cell.labelSelectedValue.frame.size.width, 100) style:UITableViewStylePlain];
            tblRanking.separatorStyle=UITableViewCellSeparatorStyleNone;
            tblRanking.delegate=self;
            tblRanking.dataSource=self;
            [tblAddTournament addSubview:tblRanking];
            isRankingOpen=YES;
            
            tblRanking.backgroundColor=[UIColor colorWithRed:3.0f/255.0f green:41.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI);
            }];
        }
    }
    else if (indexPath.row==4)
    {
        if (isPlayTimeOpen) {
            [tblPlayTime removeFromSuperview];
            tblPlayTime=nil;
            isPlayTimeOpen=NO;
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI*2);
            }];
        }else{
            tblPlayTime=[[UITableView alloc] initWithFrame:CGRectMake(cell.labelSelectedValue.frame.origin.x, cell.frame.origin.y+cell.labelSelectedValue.frame.origin.y+cell.labelSelectedValue.frame.size.height+1, cell.labelSelectedValue.frame.size.width, tblAddTournament.frame.size.height-(cell.frame.origin.y+cell.labelSelectedValue.frame.origin.y+cell.labelSelectedValue.frame.size.height+1)) style:UITableViewStylePlain];
            tblPlayTime.separatorStyle=UITableViewCellSeparatorStyleNone;
            tblPlayTime.delegate=self;
            tblPlayTime.dataSource=self;
            [tblAddTournament addSubview:tblPlayTime];
            isPlayTimeOpen=YES;
            
            tblPlayTime.backgroundColor=[UIColor colorWithRed:3.0f/255.0f green:41.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
            [UIView animateWithDuration:0.1 animations:^{
                cell.imgArrow.transform=CGAffineTransformMakeRotation(M_PI);
            }];
        }
    }
}

@end
