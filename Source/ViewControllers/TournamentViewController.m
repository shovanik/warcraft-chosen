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
#import "TournamentTableViewCell.h"
#import "GuildViewController.h"
#import "Context.h"

@interface TournamentViewController (){
    IBOutlet UITableView *tblTournament;

}

@end

@implementation TournamentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tblTournament.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark
#pragma mark UITableViewDelegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsIphone4) {
        //For Iphone4
        // NSLog(@"iPhone4");
        return 130.0f;
        
    }else{
        return 143.0f;
        //  NSLog(@"iPhone6");
    }
    
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentfire = @"Cell";
    
    TournamentTableViewCell *cell = (TournamentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentfire];
    if (cell == nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"TournamentTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        cell.imgTurnament.image = [UIImage imageNamed:@"mkw_iphn4.png"];
        cell.lblTurnament.text = @"MOST KILLS WIN";
    }else if (indexPath.row == 1) {
        cell.imgTurnament.image = [UIImage imageNamed:@"ls_iphn4.png"];
        cell.lblTurnament.text = @"LAST MAN STANDING";

    }else{
        cell.imgTurnament.image = [UIImage imageNamed:@"kfh_iphn4.png"];
        cell.lblTurnament.text = @"KING OF THE HEELS";

    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TournamentDetailsViewController *tdVC  = [[TournamentDetailsViewController alloc] initWithNibName:@"TournamentDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:tdVC animated:YES];
    
}




@end
