//
//  GraphLine.h
//  Photopular
//
//  Created by David Charlec on 23/03/10.
//  Copyright 2010 davidcharlec.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphLine : UIView {

}

@property (nonatomic, retain) UIColor *color;
@property CGFloat maxValue;
@property (nonatomic, retain) NSArray *values;
@end
