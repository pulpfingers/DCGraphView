//
//  Graph.m
//  Photopular
//
//  Created by David Charlec on 10/04/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import "PFLineChart.h"

@interface PFLineChart (Private)
- (void)handleUserTouch:(UITouch*)touch;
@end

@implementation PFLineChart

@synthesize maximumValue, verticalBar;
@synthesize delegate;

- (id) initWithOriginType:(PFLineChartOriginType)type maximumValue:(NSInteger)value {
    self = [self initWithOriginType:type];
    if(self) {
        self.maximumValue = value;
    }
    return  self;
}

- (id)initWithOriginType:(PFLineChartOriginType)type {
    self = [self initWithFrame:CGRectZero];
    if(self) {
        originType = type;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        numberOfValues = 0;
        items = [[NSMutableArray alloc] init];
        originType = PFLineChartOriginTypeAbsolute;
    }
    return self;
}

- (void)awakeFromNib {
    numberOfValues = 0;
    items = [[NSMutableArray alloc] init];
    originType = PFLineChartOriginTypeAbsolute;
}

- (void)drawRect:(CGRect)rect {

	verticalBar = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 5, 0, 1, self.bounds.size.height)];
	[verticalBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.7]];	
	[verticalBar setTag:1];
	[self addSubview:verticalBar];
	[verticalBar release];

	UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
	[bottomBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.3]];	
	[bottomBar setTag:1];
	[self addSubview:bottomBar];
	[bottomBar release];
	
	UIView *middleBar = [[UIView alloc] initWithFrame:CGRectMake(1, self.bounds.size.height / 2, self.bounds.size.width - 2, 1)];
	[middleBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.3]];
	[middleBar setTag:1];
	[self addSubview:middleBar];
	[middleBar release];

	UIView *threeQuarterBar = [[UIView alloc] initWithFrame:CGRectMake(1, self.bounds.size.height * 0.75, self.bounds.size.width - 2, 1)];
	[threeQuarterBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.1]];
	[threeQuarterBar setTag:1];
	[self addSubview:threeQuarterBar];
	[threeQuarterBar release];

	UIView *oneQuarterBar = [[UIView alloc] initWithFrame:CGRectMake(1, self.bounds.size.height * 0.25, self.bounds.size.width - 2, 1)];
	[oneQuarterBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.1]];
	[oneQuarterBar setTag:1];
	[self addSubview:oneQuarterBar];
	[oneQuarterBar release];
	
	UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(1, 0, self.bounds.size.width - 2, 1)];
	[topBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.3]];
	[topBar setTag:1];
	[self addSubview:topBar];
	[topBar release];

	UIView *leftBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.bounds.size.height)];
	[leftBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.3]];
	[leftBar setTag:1];
	[self addSubview:leftBar];
	[leftBar release];
	
	UIView *rightBar = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 1, 0, 1, self.bounds.size.height)];
	[rightBar setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.3]];
	[rightBar setTag:1];
	[self addSubview:rightBar];
	[rightBar release];
    
    NSLog(@"Draw Items => %@", items);
    
    for(PFLineChartItem *item in [items reverseObjectEnumerator]) {
        [self addSubview:item];
    }
	
}

- (void)addItem:(PFLineChartItem *)item {
    NSLog(@"New Item");
    if(originType == PFLineChartOriginTypeRelative) [item setRelativeItem:[items lastObject]];
    numberOfValues = [[item values] count];
    [items addObject:item];
    [self setNeedsDisplay];
}

-(void)addLine:(NSString *)label color:(UIColor *)color data:(NSArray*)data {	
	PFLineChartItem *item = [[PFLineChartItem alloc] initWithChart:self andValues:data];
	item.fillColor = color;
	item.maxValue = maximumValue;
    [self addItem:item];	
    [item release];
}

-(void)reset {
	NSArray *subViews = [self subviews];
	for(int i = 0; i < [subViews count]; i++) {
		if([[subViews objectAtIndex:i] tag] == 0) {
			[[subViews objectAtIndex:i] removeFromSuperview];
		}
	}
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self handleUserTouch:(UITouch*)[touches anyObject]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self handleUserTouch:(UITouch*)[touches anyObject]];
}

-(void)handleUserTouch:(UITouch*)touch {
	
	CGFloat touchPosition = [touch locationInView:self].x;
	
	if(touchPosition > self.bounds.size.width) {
		touchPosition = self.bounds.size.width;
	} else if (touchPosition < 0) {
		touchPosition = 0;
	} else {
		// Only notify touch events to delegate if the touch is on the graph
		[self.delegate graph:self wasTouched:touch];
	}
	
	[verticalBar setCenter:CGPointMake(touchPosition, verticalBar.bounds.size.height/2)];
	
	CGFloat xRange = self.frame.size.width / (numberOfValues - 1);
	[self.delegate graph:self wasTouchedAtPosition:round(touchPosition/xRange)];	 
}

- (void)dealloc {
    [super dealloc];
}


@end
