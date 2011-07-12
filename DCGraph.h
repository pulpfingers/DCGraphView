//
//  Graph.h
//  Photopular
//
//  Created by David Charlec on 10/04/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphLine.h"

@protocol DCGraphDelegate;

@interface DCGraph : UIView {	
	NSInteger numberOfValues;
}

@property (assign) id<DCGraphDelegate> delegate;
@property (nonatomic, retain) UIView *verticalBar;

@property CGFloat maximumValue;

-(void)addLine:(NSString *)label color:(UIColor *)color data:(NSArray *)data;
-(void)reset;
-(void)handleUserTouch:(UITouch*)touch;

@end

@protocol DCGraphDelegate <NSObject>
@optional
-(void)graph:(DCGraph*)graph wasTouchedAtPosition:(NSInteger)position;
-(void)graph:(DCGraph*)graph wasTouched:(UITouch *)touch;
@end
