//
//  MSTabBar.m
//  MutiPagesDemo
//
//  Created by chen can on 12-3-28.
//  Copyright (c) 2012年 http://chencan.github.io. All rights reserved.
//

#import "CCTabBar.h"
@interface CCTabBar ()
@property (nonatomic, readwrite, assign)     NSUInteger selectedIndex;
@property (nonatomic, readwrite, strong)     NSMutableArray *tabButtonArray;
@end


@implementation CCTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.animated = YES;
        self.userInteractionEnabled = YES;
        self.selectedIndex = NSUIntegerMax;
    }
    return self;
}

#pragma mark -
#pragma mark Private

-(void)tabTouched:(UIButton *)sender {
	if (self.delegate) {
        self.selectedIndex = sender.tag - 100;
		[self.delegate tabBar:self didSelectTabAtIndex:self.selectedIndex];
        [self setNeedsLayout];
	}
}

- (void)autoTouchTab:(int)index
{
    if (self.delegate) {
        [self setSelectedIndex:index animated:NO];
		[self.delegate tabBar:self didSelectTabAtIndex:self.selectedIndex];
        [self setNeedsLayout];
	}
}

#pragma mark -
#pragma mark UIView


- (void)layoutSubviews {
	[super layoutSubviews];
    
	
	CGRect tabFrame = CGRectMake(self.tabOrigin, 0, self.tabWidth, self.bounds.size.height - 4);
	
    int i = 0;
	for (UIButton *button in self.tabButtonArray) {
		button.frame = tabFrame;
		tabFrame.origin.x += self.tabDistance + self.tabWidth;
        
        button.titleLabel.alpha = 0.5;
        
        if (i == self.selectedIndex) {
            button.titleLabel.alpha = 1;
            
            CGRect bottomViewFrame = button.frame;
            bottomViewFrame.origin.y = (self.frame.size.height - 4);
            bottomViewFrame.size.height = 2;
            
            self.bottomView.backgroundColor = button.titleLabel.textColor;
            
            CGRect currentBottomViewFrame = self.bottomView.frame;
            
            if (self.animated && !CGRectEqualToRect(currentBottomViewFrame, CGRectZero)) {
                [UIView beginAnimations:nil context:nil];
            }
            self.bottomView.frame = bottomViewFrame;
            if (self.animated && !CGRectEqualToRect(currentBottomViewFrame, CGRectZero)) {
                [UIView commitAnimations];
            }
            
            self.animated = YES;
        }
        
        i++;
	}
    

}

#pragma mark -
#pragma mark Public

- (void)setTabNum:(int)aTabNum {
    if (!self.tabButtonArray) {
		self.tabButtonArray = [[NSMutableArray alloc] initWithCapacity:2];
	}
	
    if (!self.bottomView) {
        self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.bottomView];
    }
    
	if ([self.tabButtonArray count] != aTabNum) {
		if (aTabNum < [self.tabButtonArray count]) {
			while ([self.tabButtonArray count] > aTabNum) {
				[[self.tabButtonArray lastObject] removeFromSuperview];
				[self.tabButtonArray removeLastObject];
			}
		} else {
			UIButton *button = nil;
			for (NSUInteger i = [self.tabButtonArray count]; i < aTabNum; i++) {
				button = [UIButton buttonWithType:UIButtonTypeCustom];
				button.backgroundColor = [UIColor clearColor];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                button.reversesTitleShadowWhenHighlighted = YES;
				button.tag = 100 + i;
				[button addTarget:self 
						   action:@selector(tabTouched:) 
				 forControlEvents:UIControlEventTouchDown];
				[self.tabButtonArray addObject:button];
				
				[self addSubview:button];
			}
		}
	}
    
    self.bottomView.hidden = (0 == aTabNum);
}
- (void)setTabOrigin:(float)aTabOrigin {
    _tabOrigin = aTabOrigin;
    [self setNeedsLayout];
}
- (void)setTabWidth:(float)aTabWidth {
    _tabWidth = aTabWidth;
    [self setNeedsLayout];
}
- (void)setTabDistance:(float)aTabDistance {
    _tabDistance = aTabDistance;
    [self setNeedsLayout];
}
    

- (void)setSelectedIndex:(int)aSelectedIndex animated:(BOOL)anAniamted {
    if (aSelectedIndex != self.selectedIndex) {
        if (aSelectedIndex >= 0 && aSelectedIndex < [self.tabButtonArray count]) {
            self.selectedIndex = aSelectedIndex;
            self.animated = anAniamted;
            [self setNeedsLayout];
        }
    }
}
@end
