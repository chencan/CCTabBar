//
//  MSTabBar.h
//  MutiPagesDemo
//
//  Created by chen can on 12-3-28.
//  Copyright (c) 2012年 http://chencan.github.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSTabBarDelegate;

@interface CCTabBar : UIImageView 
@property (nonatomic, readonly, strong)     NSMutableArray *tabButtonArray;
@property (nonatomic, assign)       id<MSTabBarDelegate> delegate;
@property (nonatomic, readonly, assign)     NSUInteger selectedIndex;
@property (nonatomic, assign) float   tabOrigin;
@property (nonatomic, assign) float   tabWidth;
@property (nonatomic, assign) float   tabDistance;
@property (nonatomic, assign) float   bottomViewHeight;
@property (nonatomic, strong) UIView *bottomView;

- (void)setTabNum:(NSUInteger)aTabNum;
- (void)setTabOrigin:(float)aTabOrigin;
- (void)setTabWidth:(float)aTabWidth;
- (void)setTabDistance:(float)aTabDistance;

- (void)setSelectedIndex:(NSUInteger)aSelectedIndex animated:(BOOL)aniamted;
- (void)autoTouchTab:(NSUInteger)index;
@end



@protocol MSTabBarDelegate <NSObject>

@required
- (void)tabBar:(CCTabBar *)tabBar didSelectTabAtIndex:(NSUInteger)index;

@end