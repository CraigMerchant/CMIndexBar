//
//  CMIndexBar.m
//
//  Created by Craig Merchant on 07/04/2011.
//

#import "CMIndexBar.h"

#import <QuartzCore/QuartzCore.h>

@interface CMIndexBar ()

- (void)initializeDefaults;

@end

@implementation CMIndexBar

@synthesize delegate;
@synthesize highlightedBackgroundColor;
@synthesize textColor;

- (id)init {
	if ((self = [super init])) {
        [self initializeDefaults];
	}
    
	return self;
}

- (id)initWithFrame:(CGRect)frame  {
    if ((self = [super initWithFrame:frame]))  {
        [self initializeDefaults];
    }
    
    return self;
}

- (void)initializeDefaults {
    // Default colors.
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    self.highlightedBackgroundColor = [UIColor lightGrayColor];

    // HelveticaNeue Bold 11pt is a font of native table index
    self.textFont = [UIFont fontWithName: @"HelveticaNeue-Bold" size: 11];
}

- (void)layoutSubviews 
{
	[super layoutSubviews];	

	int i=0;
	int subcount=0;
	
	for (UIView *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			subcount++;
		}
	}
	
	for (UIView *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			float ypos;
			
			if(i == 0)
			{
				ypos = 0;
			}
			else if(i == subcount-1)
			{
				ypos = self.frame.size.height-24.0;
			}
			else
			{
				float sectionheight = ((self.frame.size.height-24.0)/subcount);
				
				sectionheight = sectionheight+(sectionheight/subcount);
				
				ypos = (sectionheight*i);
			}
			
			[subview setFrame:CGRectMake(0, ypos, self.frame.size.width, 24.0)];
			
			i++;
		}
	}
}

- (void) setIndexes:(NSArray*)indexes
{	
	[self clearIndex];
	
	int i;
	
	for (i=0; i<[indexes count]; i++)
	{
		float ypos;
		
		if(i == 0)
		{
			ypos = 0;
		}
		else if(i == [indexes count]-1)
		{
			ypos = self.frame.size.height-24.0;
		}
		else
		{
			float sectionheight = ((self.frame.size.height-24.0)/[indexes count]);			
			sectionheight = sectionheight+(sectionheight/[indexes count]);
			
			ypos = (sectionheight*i);
		}
		
		UILabel *alphaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ypos, self.frame.size.width, 24.0)];
		alphaLabel.textAlignment = NSTextAlignmentCenter;
		alphaLabel.text = [indexes objectAtIndex:i];
		alphaLabel.font = self.textFont;
		alphaLabel.backgroundColor = [UIColor clearColor];
		alphaLabel.textColor = textColor;
		[self addSubview:alphaLabel];	
	}
}

- (void) clearIndex
{
	for (UIView *subview in self.subviews) 
	{
		[subview removeFromSuperview];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
  [self touchesEndedOrCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesCancelled:touches withEvent:event];
  [self touchesEndedOrCancelled:touches withEvent:event];
}

- (void) touchesEndedOrCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
 	UIView *backgroundView = (UIView*)[self viewWithTag:767];
	[backgroundView removeFromSuperview]; 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	
	UIView *backgroundview = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
	[backgroundview setBackgroundColor:highlightedBackgroundColor];
	backgroundview.layer.cornerRadius = self.bounds.size.width/2;
	backgroundview.layer.masksToBounds = YES;
	backgroundview.tag = 767;
	[self addSubview:backgroundview];
	[self sendSubviewToBack:backgroundview];
	
    if (!self.delegate) return;
	
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];

	if(touchPoint.x < 0)
	{
		return;
	}
	
	NSString *title = nil;
	int count=0;
	
	for (UILabel *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			if(touchPoint.y < subview.frame.origin.y+subview.frame.size.height)
			{
				count++;
				title = subview.text;
				break;
			}
			
			count++;
			title = subview.text;
		}
	}
	
    if ([delegate respondsToSelector: @selector(indexSelectionDidChange:index:title:)])
        [delegate indexSelectionDidChange: self index: count - 1 title: title];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

	if (!self.delegate) return;
	
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
	
	if(touchPoint.x < 0)
	{
		return;
	}
	
	NSString *title = nil;
	int count=0;
	
	for (UILabel *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			if(touchPoint.y < subview.frame.origin.y+subview.frame.size.height)
			{
				count++;
				title = subview.text;
				break;
			}
			
			count++;
			title = subview.text;
		}
	}
	
    if ([delegate respondsToSelector: @selector(indexSelectionDidChange:index:title:)])
        [delegate indexSelectionDidChange: self index: count - 1 title: title];
}

@end
