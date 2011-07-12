//
//  GraphPoint.m
//  Photopular
//
//  Created by David Charlec on 23/03/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import "GraphPoint.h"


@implementation GraphPoint
@synthesize color;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[color setFill];
	CGContextBeginPath (context); 
	CGContextAddEllipseInRect(context, rect);
	CGContextSetShadow(context, CGSizeMake(3, 3), 3);
	CGContextDrawPath(context, kCGPathFill);	
}


- (void)dealloc {
    [super dealloc];
}


@end
