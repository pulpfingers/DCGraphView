//
//  GraphLine.h
//  Photopular
//
//  Created by David Charlec on 23/03/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFLineChart;

@interface PFLineChartItem : UIView {
    
}

@property CGFloat maxValue;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, retain) NSArray *values;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) PFLineChartItem *relativeItem;

- (id)initWithChart:(PFLineChart*)chart andValues:(NSArray*)array;
- (void)addValue:(CGFloat)value;

@end
