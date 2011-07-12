//
//  GraphLine.m
//  Photopular
//
//  Created by David Charlec on 23/03/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import "GraphLine.h"
#import "GraphPoint.h"


@implementation GraphLine
@synthesize color, values, maxValue;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque = NO;
		self.tag = 0;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGFloat pointSize = 6;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShadow(context, CGSizeMake(3, 3), 3);
	float width = CGRectGetWidth(rect);
	float height = CGRectGetHeight(rect);
	float spaceBetweenPoints = width / ([values count] - 1);
	
	CGContextBeginPath (context); 
	CGContextSetLineWidth(context, 2.5f);

	NSNumberFormatter *converter = [[NSNumberFormatter alloc] init];
	
	int i;
	
	for (i = 0; i < [values count]; i++) {
		NSInteger views = [[values objectAtIndex:i] intValue];
		CGFloat pointX = width - (spaceBetweenPoints * i);
		CGFloat pointY = height - (height * views / maxValue);
		
		if(i > 0) {
			CGContextAddLineToPoint(context, pointX, pointY);
		} else {
			CGContextMoveToPoint(context, pointX, pointY);
		}
		GraphPoint *point = [[GraphPoint alloc] initWithFrame:CGRectMake((pointX - pointSize/2), height, pointSize, pointSize)];
		point.color = color;
		[self addSubview:point];
		[UIView beginAnimations:@"point_animation" context:nil];		
		[UIView setAnimationDuration:1.0];
		[point setFrame:CGRectMake((pointX - pointSize/2), (pointY - pointSize/2), pointSize, pointSize)];
		[UIView commitAnimations];	
		
		[point release];
		
	}
	[color setStroke];
	CGContextDrawPath(context, kCGPathStroke);	
	[converter release];
}


- (void)dealloc {
    [super dealloc];
}


@end
