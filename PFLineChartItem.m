//
//  PFLineChartItem.m
//  PFLineChart
//
//  Created by David Charlec on 23/11/11.
//  Copyright 2011 Pulpfingers. All rights reserved.
//

#import "PFLineChartItem.h"
#import "PFLineChart.h"

@interface PFLineChartItem (Private)
- (CGPoint)relativePointForIndex:(NSInteger)index;
@end

@implementation PFLineChartItem

@synthesize values;
@synthesize maxValue;
@synthesize fillColor;
@synthesize relativeItem;
@synthesize points;

-(NSString *)description {
    return [NSString stringWithFormat:@"PFLineChartItem with values => %@", self.values];
}

- (id)initWithChart:(PFLineChart*)chart andValues:(NSArray*)array {
    self = [self initWithFrame:chart.bounds];
    if(self) {
        if(array) {
            self.values = array;
        } else {
            self.values = [NSArray array];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
        self.maxValue = 1;
        self.fillColor = [UIColor greenColor];
        self.points = [NSMutableArray array];
        self.values = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if([self.values count] > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        float width = CGRectGetWidth(rect);
        float height = CGRectGetHeight(rect);
        float spaceBetweenPoints = width / ([values count] - 1);

        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);	
        CGContextBeginPath(context);
        CGPoint relativePoint;
        
        for (int i = 0; i < [self.values count]; i++) {
            
            CGFloat value = [[self.values objectAtIndex:i] floatValue];
            CGPoint point = CGPointZero;
            point.x = spaceBetweenPoints * i;
            point.y = height * value / maxValue;
                    
            if(self.relativeItem) {
                relativePoint = [self relativePointForIndex:i];
                point.y = relativePoint.y - point.y;
                NSLog(@"RelativePoint Y => %f", relativePoint.y);
            } else {
                point.y = height - point.y;
            }
            
            NSLog(@"Y > %f", point.y);        
            
            if(i > 0) {
                CGContextAddLineToPoint(context, point.x, point.y);
            } else {
                CGContextMoveToPoint(context, point.x, point.y);
            }		

            [self.points addObject:[NSValue valueWithCGPoint:point]];
        }
        
        if(self.relativeItem) {
            for (int j = [self.values count] - 1; j < [self.values count]; j--) {
                relativePoint = [self relativePointForIndex:j];
                CGContextAddLineToPoint(context, relativePoint.x, relativePoint.y);
            } 
        } else {
            CGContextAddLineToPoint(context, width, height);        
            CGContextAddLineToPoint(context, 0, height);

        }
        
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
}

- (void)addValue:(CGFloat)value {
    self.values = [self.values arrayByAddingObject:[NSNumber numberWithFloat:value]];
    [self setNeedsDisplay];
}

- (CGPoint)relativePointForIndex:(NSInteger)index {
    if(!self.relativeItem) {
        return CGPointZero;   
    } else {
        NSValue *point = (NSValue*)[self.relativeItem.points objectAtIndex:index];
        return [point CGPointValue];
    }
}

- (void)dealloc {
    [fillColor release];
    [points release];
    [super dealloc];
}


@end
