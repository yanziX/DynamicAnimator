//
//  UIView+extension.h
//  动画Demo
//
//  Created by storm on 2017/5/22.
//  Copyright © 2017年 strom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extension)

/**
 * view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat cy_originX;

/**
 * view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat cy_originY;

/**
 * view.frame.origin
 */
@property (nonatomic, assign) CGPoint cy_origin;

/**
 * view.center.x
 */
@property (nonatomic, assign) CGFloat cy_centerX;

/**
 * view.center.y
 */
@property (nonatomic, assign) CGFloat cy_centerY;

/**
 * view.center
 */
@property (nonatomic, assign) CGPoint cy_center;

/**
 * view.frame.size.width
 */
@property (nonatomic, assign) CGFloat cy_width;

/**
 * view.frame.size.height
 */
@property (nonatomic, assign) CGFloat cy_height;

/**
 * view.frame.size
 */
@property (nonatomic, assign) CGSize  cy_size;

/**
 * view.frame.size.height + view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat cy_bottomY;

/**
 * view.frame.size.width + view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat cy_rightX;


@end
