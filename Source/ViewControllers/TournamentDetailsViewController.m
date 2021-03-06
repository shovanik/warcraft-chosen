//
//  TournamentDetailsViewController.m
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "TournamentDetailsViewController.h"
#import "Context.h"
#import "TournamentDetailsTableViewCell.h"
#import "AddTournamentViewController.h"
#import "SlideOutMenuViewController.h"
#import "WorldMapViewController.h"

@interface TournamentDetailsViewController ()<UITableViewDataSource, UITableViewDelegate,CustomConfirmationViewControllerDelegate>
{
     CGFloat _offset;
    IBOutlet UITableView *tblTournamentDetail;
    
    NSMutableArray *arrResponse;
    CustomConfirmationViewController *confirmationDiagolueView;
    
    NSInteger selectedIndex;
}

@end

@implementation TournamentDetailsViewController


#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;

    /*
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        
    }else{
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];

        //  NSLog(@"iPhone6");
        
    }
    */
    
    
    tblTournamentDetail.backgroundColor = [UIColor clearColor];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.activityIndicatorView setHidesWhenStopped:YES];
    [self.activityIndicatorView startAnimating];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[WebService service] callGetNearTournamentWithUserID:user.strID CategoryID:_tournamentCategory.strID WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Error" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //[self.navigationController popViewControllerAnimated:YES];
            }];
            [controller addAction:actionOK];
            [self presentViewController:controller animated:YES completion:^{
                
            }];
        }else{
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrResponse=(NSMutableArray*)result;
            }else{
                arrResponse=[[NSMutableArray alloc] init];
            }
            [tblTournamentDetail reloadData];
        }
        [self.activityIndicatorView stopAnimating];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Table Delegate Method
#pragma mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrResponse.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        return 100.0f;
    }else{
        return 129.0f;
    }
    return 0.0f;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tableCellIdentfire = @"Iphn4Cell";
    
    TournamentDetailsTableViewCell *cell = (TournamentDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentfire];
    if (cell == nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"TournamentDetailsTableViewCell_iphn4" owner:self options:nil]objectAtIndex:0];
    }
    
    ModelTournamentSubCategory *obj=[arrResponse objectAtIndex:indexPath.row];
    
    cell.imgGroup.image = [UIImage imageNamed:@"trmDet_single_iphn4.png"];
    cell.lblTurName.text=obj.strTitle;
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    confirmationDiagolueView=[[CustomConfirmationViewController alloc] initWithNibName:@"CustomConfirmationViewController" bundle:nil];
    confirmationDiagolueView.view.frame=[[UIScreen mainScreen] bounds];
    [self.view addSubview:confirmationDiagolueView.view];
    confirmationDiagolueView.delegate=self;
    
    selectedIndex=indexPath.row;
}

#pragma mark
#pragma mark IBAction Method
#pragma mark

-(IBAction)addButtonTapped:(id)sender
{
    
}

#pragma mark
#pragma mark CustomConfirmationViewControllerDelegate Method
#pragma mark

-(void)didYesPressed
{
    NSLog(@"didYesPressed");
    
    ModelTournamentSubCategory *obj=[arrResponse objectAtIndex:selectedIndex];
    [confirmationDiagolueView.view removeFromSuperview];
    WorldMapViewController *master=[[WorldMapViewController alloc] initWithNibName:@"WorldMapViewController" bundle:nil];
    master.isCalledFromTournament=YES;
    master.strTournamentID=obj.strID;
    [self.navigationController pushViewController:master animated:YES];
}

-(void)didNoPressed
{
    NSLog(@"didNoPressed");
    [confirmationDiagolueView.view removeFromSuperview];
}


@end
