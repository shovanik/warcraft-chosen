//
//  GuildViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "GuildViewController.h"
#import "SlideOutMenuViewController.h"
#import "LandingViewController.h"
#import "Context.h"
#import "AppDelegate.h"
#import "StepOneViewController.h"
#import "ModelGuild.h"
#import "ImageViewGuild.h"
#import "CustomConfirmationViewController.h"

#import "ModelInAppPurchase.h"
#import <StoreKit/StoreKit.h>

//#import "Guilds.h"
//#import "STTwitter.h"



@interface GuildViewController ()<UIAlertViewDelegate,CustomConfirmationViewControllerDelegate>
{
//     STTwitterAPI *twitter;
//    
    IBOutlet NSLayoutConstraint * contentHeightConst;
    IBOutlet NSLayoutConstraint * contentTopBarHeightConst;
    IBOutlet NSLayoutConstraint * contentMiddleBgHeightConst;
    IBOutlet NSLayoutConstraint * contentButtomBarHeightConst;
    
    IBOutlet NSLayoutConstraint * damageLeadConst;
    IBOutlet NSLayoutConstraint * damageWidthConst;
    IBOutlet NSLayoutConstraint * damageHeightConst;
    IBOutlet NSLayoutConstraint * damageButtomSpaceConst;
    IBOutlet NSLayoutConstraint * damageTextLeadConst;
    IBOutlet NSLayoutConstraint * damageTextTopConst;
    IBOutlet NSLayoutConstraint * damageBarLeadConst;
    IBOutlet NSLayoutConstraint * damageBarButtomConst;
    
    IBOutlet NSLayoutConstraint * accurencyLeadConst;
    IBOutlet NSLayoutConstraint * accurencyWidthConst;
    IBOutlet NSLayoutConstraint * accurencyHeightConst;
    IBOutlet NSLayoutConstraint * accurencyButtomSpaceConst;
    IBOutlet NSLayoutConstraint * accurencyTextLeadConst;
    IBOutlet NSLayoutConstraint * accurencyTextTopConst;
    IBOutlet NSLayoutConstraint * accurencyBarLeadConst;
    IBOutlet NSLayoutConstraint * accurencyBarButtomConst;
    
    IBOutlet NSLayoutConstraint * checkMarkLeadConst;
    IBOutlet NSLayoutConstraint * checkMarkTopConst;
    
    IBOutlet NSLayoutConstraint * starLeadConst;
    IBOutlet NSLayoutConstraint * starTopConst;
    
    IBOutlet NSLayoutConstraint * dolartopConst;
    IBOutlet NSLayoutConstraint * dolarTrailConst;
    
    
    IBOutlet NSLayoutConstraint * buyButLeadConst;
    IBOutlet NSLayoutConstraint * buyButWeidthConst;
    IBOutlet NSLayoutConstraint * buyButHeightConst;
    
    IBOutlet NSLayoutConstraint * exchangeButTrailConst;
    IBOutlet NSLayoutConstraint * exchangeButWeidthConst;
    IBOutlet NSLayoutConstraint * exchangeButHeightConst;
    
    IBOutlet UIImageView *background;
    IBOutlet UIImageView *imgStar;
    IBOutlet UIPageControl *pageControl;
    
    
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnPrevious;
    IBOutlet UIImageView *nabImgView;
    IBOutlet UILabel *lblGuildName;
    IBOutlet UILabel *lblPrice;
    IBOutlet UILabel *lblDamage;
    IBOutlet UILabel *lblAccuracy;
    IBOutlet GuildImageView *imgSliderDamage;
    IBOutlet GuildImageView *imgSliderAccuracy;
    CustomConfirmationViewController *confirmationDiagolueView;
    
    
    NSMutableDictionary *guildDictionary;
    NSMutableArray *arrAllGuilds,*arrUserGuilds;
    
    InfinitePagingView *pagingView;
    
    CGRect guildSize;
    
    ModelGuild *guildSelected;
    int globalPageIndex;
    
    NSArray *inAppProducts;
    NSNumberFormatter * priceFormatter;
    
}


@end

@implementation GuildViewController

#pragma mark
#pragma mark View Initialization Method
#pragma mark


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrAllGuilds=[[NSMutableArray alloc] init];
    arrUserGuilds=[[NSMutableArray alloc] init];
    
    [self setUIAndConstraint];
    
       pageControl.pageIndicatorTintColor = [UIColor colorWithRed:60.0f/255.0f green:59.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:110.0f/255.0f green:207.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    
    
    
    
    // for ios 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    priceFormatter = [[NSNumberFormatter alloc] init];
    [priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
}

-(void) viewWillAppear:(BOOL)animated
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:animated];
    if (self.isNetworkRechable) {
        [self loadAllGuildFromServer];
    }
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark Web Service Interaction Method
#pragma mark

-(void)loadAllGuildFromServer
{
    [self.activityIndicatorView startAnimating];
    [[WebService service] callGetAllGuildWithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        [self.activityIndicatorView stopAnimating];
        if (isError) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrAllGuilds=(NSMutableArray*)result;
                pageControl.numberOfPages = arrAllGuilds.count;
                [self updateUIForGuild:[arrAllGuilds firstObject]];
                [self loadAllGuildForUser];
            }
        }
    }];
}
-(void)loadAllGuildForUser
{
    [self.activityIndicatorView startAnimating];
    [[WebService service] callGetGuildsForUserId:user.strID WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        [self.activityIndicatorView stopAnimating];
        if (isError) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrUserGuilds=(NSMutableArray*)result;
                [self.activityIndicatorView stopAnimating];
                [self makeUIDesign];
            }
        }
    }];
}

-(void)addGuildToTheUserWithGuild:(ModelGuild*)guild
{
    if (self.isNetworkRechable) {
        [self.activityIndicatorView startAnimating];
        [[WebService service] callAddGuildForGuildID:guild.strId UserID:user.strID CompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            [self.activityIndicatorView stopAnimating];
            if (isError) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                [arrUserGuilds addObject:guild];
            }
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

#pragma mark
#pragma mark Design Method
#pragma mark

-(void)setUIAndConstraint
{
    
    
    pagingView = [[InfinitePagingView alloc] init];
    if (IsIphone4) {
        pagingView.frame = CGRectMake(0.f, 50,320, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:20];
        guildSize = CGRectMake(0.f, 0.f, 320, 150);

        
    }else if (IsIphone5) {
        pagingView.frame = CGRectMake(0.f, 90,320, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:20];
        guildSize = CGRectMake(0.f, 0.f, 320, 150);

        //buyButLeadConst.constant =
        
        
    }else if (IsIphone6) {
        guildSize = CGRectMake(0.f, 0.f, 375, 208);
        pagingView.frame = CGRectMake(0.f, 30, 375, 260.f);
        pagingView.pageSize = CGSizeMake(375.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:24];
        
        checkMarkLeadConst.constant = 20;
        checkMarkTopConst.constant = 8;
        starLeadConst.constant = 13;
        starTopConst.constant = 25;
        dolartopConst.constant = 11;
        dolarTrailConst.constant = 20;
        
        damageTextTopConst.constant = -8;
        damageLeadConst.constant = -41;
        damageTextLeadConst.constant = 6;
        damageBarLeadConst.constant = 9;
        damageBarButtomConst.constant = -13;
        
        accurencyTextTopConst.constant = -8;
        accurencyLeadConst.constant = -41;
        accurencyTextLeadConst.constant = 6;
        accurencyBarLeadConst.constant = 9;
        accurencyBarButtomConst.constant = 13;
        
        buyButLeadConst.constant = 48;
        buyButWeidthConst.constant = 131;
        buyButHeightConst.constant = 41;
        
        exchangeButTrailConst.constant = 48;
        exchangeButWeidthConst.constant = 131;
        exchangeButHeightConst.constant = 41;
        
        contentHeightConst.constant = 406;
        contentTopBarHeightConst.constant = 86;
        contentButtomBarHeightConst.constant = 75;
        accurencyButtomSpaceConst.constant = 15;
        accurencyWidthConst.constant = 332;
        damageButtomSpaceConst.constant = 9;
        damageWidthConst.constant = 332;
        damageHeightConst.constant = 73;
        accurencyHeightConst.constant = 73;
        checkMarkTopConst.constant = 8;
        starTopConst.constant = 25;
        dolartopConst.constant = 10;
        
    }else{
        guildSize = CGRectMake(0.f, 0.f, 414, 230);

        pagingView.frame = CGRectMake(0.f, 30, 414, 260.f);
        pagingView.pageSize = CGSizeMake(414.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:24];
        
        checkMarkLeadConst.constant = 22;
        checkMarkTopConst.constant = 9;
        starLeadConst.constant = 14;
        starTopConst.constant = 28;
        dolartopConst.constant = 12;
        dolarTrailConst.constant = 22;
        
        damageTextTopConst.constant = -9;
        damageLeadConst.constant = -45;
        damageTextLeadConst.constant = 7;
        damageBarLeadConst.constant = 10;
        damageBarButtomConst.constant = -14;
        
        accurencyTextTopConst.constant = -9;
        accurencyLeadConst.constant = -45;
        accurencyTextLeadConst.constant = 7;
        accurencyBarLeadConst.constant = 10;
        accurencyBarButtomConst.constant = 14;

        buyButLeadConst.constant = 52;
        buyButWeidthConst.constant = 144;
        buyButHeightConst.constant = 45;
        
        exchangeButTrailConst.constant = 52;
        exchangeButWeidthConst.constant = 144;
        exchangeButHeightConst.constant = 45;
        
        contentHeightConst.constant = 484;
        contentTopBarHeightConst.constant = 95;
        contentButtomBarHeightConst.constant = 83;
        accurencyButtomSpaceConst.constant = 17;
        accurencyWidthConst.constant = 367;
        damageButtomSpaceConst.constant = 10;
        damageWidthConst.constant = 367;
        damageHeightConst.constant = 81;
        accurencyHeightConst.constant = 81;
    }
    pagingView.delegate = self;
    pagingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pagingView];

    
}

-(void)makeUIDesign
{
    for (ModelGuild *gObj in arrAllGuilds) {
        ImageViewGuild *imageView=[[ImageViewGuild alloc] initWithFrame:guildSize];
        [pagingView addPageView:imageView];
        [imageView setImageFromURL:gObj.strGuildImage];
    }
    [btnPrevious addTarget:pagingView action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    [btnNext addTarget:pagingView action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateUIForGuild:(ModelGuild*)guild
{
    guildSelected=guild;
    lblGuildName.text = [guild.strName uppercaseString];
    lblDamage.text=[NSString stringWithFormat:@"Damage %@%%",[guild.strDamage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [imgSliderDamage setPercentage:[[guild.strDamage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] integerValue]];
    lblAccuracy.text=[NSString stringWithFormat:@"Accuracy %@%%",[guild.strAccuracy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [imgSliderAccuracy setPercentage:[[guild.strAccuracy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] integerValue]];
    lblPrice.text=[NSString stringWithFormat:@"%@ $",[guild.strPrice stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    switch ([[guild.strRating stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] integerValue]) {
        case 0:
            imgStar.image=[UIImage imageNamed:@"zero_star.png"];
            break;
        case 1:
            imgStar.image=[UIImage imageNamed:@"one_star.png"];
            break;
        case 2:
            imgStar.image=[UIImage imageNamed:@"two_star.png"];
            break;
        case 3:
            imgStar.image=[UIImage imageNamed:@"three_star.png"];
            break;
        case 4:
            imgStar.image=[UIImage imageNamed:@"four_star.png"];
            break;
        case 5:
            imgStar.image=[UIImage imageNamed:@"five_star.png"];
            break;
        default:
            break;
    }
}

#pragma mark
#pragma mark InfinitePagingViewDelegate Method
#pragma mark

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    ModelGuild *guild = [arrAllGuilds objectAtIndex:pageIndex];
    
    //Store the current pageIndex to globalPageIndex
    globalPageIndex=(int)pageIndex;
    
    pageControl.currentPage = pageIndex;
    [self updateUIForGuild:guild];
}

#pragma mark
#pragma mark IBAction Method
#pragma mark

-(IBAction)btnBuyPressed:(id)sender
{
    /*if ([arrUserGuilds getGuildIndex:guildSelected]>=0) {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Guild is already added to the user." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else{
        [self addGuildToTheUserWithGuild:guildSelected];
    }*/
    
    [self reload];
}

-(IBAction)btnExchangePressed:(id)sender
{
    
}

#pragma mark
#pragma mark Fetch InApp Products
#pragma mark


- (void)reload
{
    [self.activityIndicatorView startAnimating];
    inAppProducts = nil;
    [[ModelInAppPurchase sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success)
        {
            inAppProducts = products;
            if (inAppProducts.count>0)
            {
                SKProduct * product = (SKProduct *) inAppProducts[globalPageIndex];
                NSLog(@"Selected Product Details: %@ %@ %0.2f",
                      product.productIdentifier,
                      product.localizedTitle,
                      product.price.floatValue);
                
                
                confirmationDiagolueView=[[CustomConfirmationViewController alloc] initWithNibName:@"CustomConfirmationViewController" bundle:nil];
                
                
                confirmationDiagolueView.messageValue=[NSString stringWithFormat:@"%@ \n Description: %@\nPrice: %@",product.localizedTitle,product.localizedDescription,product.price];
                confirmationDiagolueView.view.frame=[[UIScreen mainScreen] bounds];
                [self.view addSubview:confirmationDiagolueView.view];
                confirmationDiagolueView.delegate=self;
                confirmationDiagolueView.view.tag=globalPageIndex;
                
                /*UIAlertView *buyAlert= [[UIAlertView alloc] initWithTitle:product.localizedTitle message:[NSString stringWithFormat:@"Description:%@ \nPrice:%@",product.localizedDescription,[priceFormatter stringFromNumber:product.price]] delegate:self cancelButtonTitle:@"Buy" otherButtonTitles:@"Cancel",nil];
                
                buyAlert.tag=globalPageIndex;
                [buyAlert show];*/
            }
        
            [self.activityIndicatorView stopAnimating];
        }
    }];
}

#pragma mark
#pragma mark AlertView Delegate Methods
#pragma mark

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked: %@ atIndex: %ld",[alertView buttonTitleAtIndex:buttonIndex],(long)buttonIndex);
    
    if (buttonIndex==0)
    {
        SKProduct *product = inAppProducts[alertView.tag];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[ModelInAppPurchase sharedInstance] buyProduct:product];
    }

}

#pragma mark
#pragma mark CustomConfirmationViewControllerDelegate Method
#pragma mark

-(void)didYesPressed
{
    NSLog(@"didYesPressed");
    [confirmationDiagolueView.view removeFromSuperview];
    SKProduct *product = inAppProducts[confirmationDiagolueView.view.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[ModelInAppPurchase sharedInstance] buyProduct:product];
}

-(void)didNoPressed
{
    NSLog(@"didNoPressed");
    [confirmationDiagolueView.view removeFromSuperview];
}

#pragma mark
#pragma mark Notification
#pragma mark

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [inAppProducts enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier])
        {
            //[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            //*stop = YES;
            
            NSLog(@"Notification against %@ registered.",product.productIdentifier);
        }
    }];
    
}

@end
