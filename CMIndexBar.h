//
//  indexBar.h
//
//  Created by Craig Merchant on 07/04/2011.
//  Copyright 2011 RaptorApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCore/QuartzCore.h"

@protocol CMIndexBarDelegate;

@interface CMIndexBar : UIView {
	NSObject<CMIndexBarDelegate> *delegate;
	
	UIColor *highlightedBackgroundColor;
	UIColor *textColor;
}

- (id)init;
- (id)initWithFrame:(CGRect)frame;
- (void) setIndexes:(NSArray*)indexes;
- (void) clearIndex;

@property (nonatomic, assign) NSObject<CMIndexBarDelegate> *delegate;
@property (nonatomic, retain) UIColor *highlightedBackgroundColor;
@property (nonatomic, retain) UIColor *textColor;

@end

@protocol CMIndexBarDelegate<NSObject>
@optional
- (void)indexSelectionDidChange:(CMIndexBar *)IndexBar:(int)index:(NSString*)title;
@end