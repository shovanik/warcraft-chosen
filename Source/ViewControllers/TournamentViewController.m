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
    
    NSMutableArray *arrResponse;
}

@end

@implementation TournamentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tblTournament.backgroundColor = [UIColor clearColor];
    
    [self.activityIndicatorView setHidesWhenStopped:YES];
    [self.activityIndicatorView startAnimating];
    tblTournament.backgroundColor=[UIColor clearColor];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    arrResponse=[[NSMutableArray alloc] init];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[WebService service] callGetTournamentCategoryWithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:^{
                [self.activityIndicatorView stopAnimating];
            }];
        }else{
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrResponse=(NSMutableArray*)result;
                
                tblTournament.dataSource=self;
                tblTournament.delegate=self;
                [tblTournament reloadData];
                [self.activityIndicatorView stopAnimating];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark UITableViewDelegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrResponse.count;
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
    
    
    ModelTournamentCategory *category=[arrResponse objectAtIndex:indexPath.row];
    cell.lblTurnament.text = [category.strName uppercaseString];
    
    if (indexPath.row == 0) {
        cell.imgTurnament.image = [UIImage imageNamed:@"mkw_iphn4.png"];
        [cell.imgSlider setPercentage:40];
    }else if (indexPath.row == 1) {
        cell.imgTurnament.image = [UIImage imageNamed:@"ls_iphn4.png"];
        [cell.imgSlider setPercentage:60];
    }else{
        cell.imgTurnament.image = [UIImage imageNamed:@"kfh_iphn4.png"];
        [cell.imgSlider setPercentage:80];
    }
    cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TournamentDetailsViewController *tdVC  = [[TournamentDetailsViewController alloc] initWithNibName:@"TournamentDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:tdVC animated:YES];
    
}




@end
