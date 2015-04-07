//
//  HorizontalScroller.h
//  AdaptivePattern
//
//  Created by Kaustav Shee on 3/20/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContractHorizontalScroller;

@protocol ContractHorizontalScrollerDelegate <NSObject>

@required
// ask the delegate how many views he wants to present inside the horizontal scroller
- (NSInteger)numberOfViewsForHorizontalScroller:(ContractHorizontalScroller*)scroller;

// ask the delegate to return the view that should appear at <index>
- (UIView*)horizontalScroller:(ContractHorizontalScroller*)scroller viewAtIndex:(int)index;

// inform the delegate what the view at <index> has been clicked
- (void)horizontalScroller:(ContractHorizontalScroller*)scroller clickedViewAtIndex:(int)index;

@optional
// ask the delegate for the index of the initial view to display. this method is optional
// and defaults to 0 if it's not implemented by the delegate
- (NSInteger)initialViewIndexForHorizontalScroller:(ContractHorizontalScroller*)scroller;
-(BOOL)setPaggingEnableForHorizontalScroller:(ContractHorizontalScroller*)scroller;
-(CGFloat)setPaddingForHorizontalScroller:(ContractHorizontalScroller*)scroller;

@end

@interface ContractHorizontalScroller : UIView

@property(weak,nonatomic) IBOutlet id <ContractHorizontalScrollerDelegate> delegate;

-(void)reloadData;

@end





