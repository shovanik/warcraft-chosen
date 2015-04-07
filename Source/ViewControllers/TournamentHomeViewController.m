//
//  TournamentHomeViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 4/6/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "TournamentHomeViewController.h"
#import "TournamentViewController.h"


@interface TournamentHomeViewController ()

@end

@implementation TournamentHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnCreatePressed:(id)sender
{
    TournamentViewController *master=[[TournamentViewController alloc] initWithNibName:@"TournamentViewController" bundle:nil];
    [self.navigationController pushViewController:master animated:YES];
    strPurpose=@"CREATE";
}

-(IBAction)btnJoinPressed:(id)sender
{
    TournamentViewController *master=[[TournamentViewController alloc] initWithNibName:@"TournamentViewController" bundle:nil];
    [self.navigationController pushViewController:master animated:YES];
    strPurpose=@"JOIN";
}

@end
