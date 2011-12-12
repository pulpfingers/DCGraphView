//
//  Graph.h
//  Photopular
//
//  Created by David Charlec on 10/04/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFLineChartItem.h"

typedef enum {
    PFLineChartOriginTypeAbsolute = 0,
    PFLineChartOriginTypeRelative
} PFLineChartOriginType;

typedef enum {
    PFLineChartSelectionViewTypeSolid = 0,
    PFLineChartSelectionViewTypeDashed
} PFLineChartSelectionViewType;

@protocol PFLineChartDelegate;

@interface PFLineChart : UIView {	
	NSInteger numberOfValues;
    NSMutableArray *items;
    PFLineChartOriginType originType;
}

@property (assign) id<PFLineChartDelegate> delegate;
@property (nonatomic, retain) UIView *verticalBar;

@property CGFloat maximumValue;
//@property BOOL manualMaximumValue;

- (id)initWithOriginType:(PFLineChartOriginType)originType maximumValue:(NSInteger)value;
- (id)initWithOriginType:(PFLineChartOriginType)originType;

- (void)addItem:(PFLineChartItem *)item;
- (void)addLine:(NSString *)label color:(UIColor *)color data:(NSArray *)data;
- (void)reset;

@end

@protocol PFLineChartDelegate <NSObject>
@optional
- (void)graph:(PFLineChart*)graph wasTouchedAtPosition:(NSInteger)position;
- (void)graph:(PFLineChart*)graph wasTouched:(UITouch *)touch;
@end
