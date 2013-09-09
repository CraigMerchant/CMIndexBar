//
//  indexBar.h
//
//  Created by Craig Merchant on 07/04/2011.
//  Copyright 2011 RaptorApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CMIndexBarDelegate;

@interface CMIndexBar : UIView

- (id)init;
- (id)initWithFrame:(CGRect)frame;
- (void)setIndexes:(NSArray*)indexes;
- (void)clearIndex;

@property (nonatomic, weak) id<CMIndexBarDelegate> delegate;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@end

@protocol CMIndexBarDelegate<NSObject>
@optional
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString*)title;
@end