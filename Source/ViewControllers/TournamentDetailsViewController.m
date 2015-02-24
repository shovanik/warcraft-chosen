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

@interface TournamentDetailsViewController (){
     CGFloat _offset;
}

@end

@implementation TournamentDetailsViewController
@synthesize navTitleLabel, TournamentDetailsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;

    
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        
    }else{
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];

        //  NSLog(@"iPhone6");
        
    }
    self.TournamentDetailsTableView.backgroundColor = [UIColor clearColor];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        return 100.0f;
        
    }else{
        return 129.0f;

        
        //  NSLog(@"iPhone6");
        
    }

}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tableCellIdentfire = @"Iphn4Cell";
    
    TournamentDetailsTableViewCell *cell = (TournamentDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentfire];
    NSArray* topLevelObjects = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TournamentDetailsTableViewCell_iphn4" owner:self options:nil];
        
    }else{
        topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TournamentDetailsTableViewCell" owner:self options:nil];
        
        //  NSLog(@"iPhone6");
        
    }

    
    if (cell == nil)
    {
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (TournamentDetailsTableViewCell *)currentObject;
                break;
            }
        }
    }
    if ([indexPath row] == 1) {
        cell.pubButton.hidden = YES;
        cell.turNameLabel.text = @"GAME 2";
        cell.groupImageView.image = [UIImage imageNamed:@"trmDet_single_iphn4.png"];
    }else if ([indexPath row] == 2) {
        cell.priButton.hidden = YES;
        cell.turNameLabel.text = @"GAME 3";
    }
    return cell;

}
-(IBAction)addButtonTapped:(id)sender
{
    AddTournamentViewController *atVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        atVC = [[AddTournamentViewController alloc] initWithNibName:@"AddTournamentViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        atVC =  [[AddTournamentViewController alloc] initWithNibName:@"AddTournamentViewController" bundle:nil];
        
        //  NSLog(@"iPhone6");
        
    }
    

    
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
