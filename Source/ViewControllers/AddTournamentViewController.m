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


@interface AddTournamentViewController (){
    CGFloat _offset;
    IBOutlet UITableView *tblAddTournament;
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
    tblAddTournament.backgroundColor = [UIColor clearColor];

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


#pragma mark
#pragma mark UITableViewDelegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return 0;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentfire = @"Cell";
    
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

    }
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];//first get total rows in that section by current indexPath.
    if(indexPath.row == totalRow -1){
        cell.labelTitle.text = @"Radious";
        cell.btnselect.hidden = NO;
        cell.imgArrow.hidden = YES;
        
        //this is the last row in section.
    }

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TournamentDetailsViewController *tdVC  = [[TournamentDetailsViewController alloc] initWithNibName:@"TournamentDetailsViewController" bundle:nil];
//    [self.navigationController pushViewController:tdVC animated:YES];
    
}
@end
