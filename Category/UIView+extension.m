//
//  UIView+extension.m
//  动画Demo
//
//  Created by storm on 2017/5/22.
//  Copyright © 2017年 strom. All rights reserved.
//

#import "UIView+extension.h"

#import "UIView+extension.h"

@implementation UIView (extension)

- (void)setCy_origin:(CGPoint)cy_origin {
    CGRect frame = self.frame;
    frame.origin = cy_origin;
    self.frame = frame;
}

- (CGPoint)cy_origin {
    return self.frame.origin;
}

- (void)setCy_originX:(CGFloat)cy_originX {
    [self setCy_origin:CGPointMake(cy_originX, self.cy_originY)];
}

- (CGFloat)cy_originX {
    return self.cy_origin.x;
}

- (void)setCy_originY:(CGFloat)cy_originY {
    [self setCy_origin:CGPointMake(self.cy_originX, cy_originY)];
}

- (CGFloat)cy_originY {
    return self.cy_origin.y;
}

- (void)setCy_center:(CGPoint)cy_center {
    self.center = cy_center;
}

- (CGPoint)cy_center {
    return self.center;
}

- (void)setCy_centerX:(CGFloat)cy_centerX {
    [self setCy_center:CGPointMake(cy_centerX, self.cy_centerY)];
}

- (CGFloat)cy_centerX {
    return self.cy_center.x;
}

- (void)setCy_centerY:(CGFloat)cy_centerY {
    [self setCy_center:CGPointMake(self.cy_centerX, cy_centerY)];
}

- (CGFloat)cy_centerY {
    return self.cy_center.y;
}

- (void)setCy_size:(CGSize)cy_size {
    CGRect frame = self.frame;
    frame.size = cy_size;
    self.frame = frame;
}

- (CGSize)cy_size {
    return self.frame.size;
}

- (void)setCy_width:(CGFloat)cy_width {
    self.cy_size = CGSizeMake(cy_width, self.cy_height);
}

- (CGFloat)cy_width {
    return self.cy_size.width;
}

- (void)setCy_height:(CGFloat)cy_height {
    self.cy_size = CGSizeMake(self.cy_width, cy_height);
}

- (CGFloat)cy_height {
    return self.cy_size.height;
}

- (CGFloat)cy_bottomY {
    return self.cy_originY + self.cy_height;
}

- (void)setCy_bottomY:(CGFloat)cy_bottomY {
    self.cy_originY = cy_bottomY - self.cy_height;
}

- (CGFloat)cy_rightX {
    return self.cy_originX + self.cy_width;
}

- (void)setCy_rightX:(CGFloat)cy_rightX {
    self.cy_originX = cy_rightX - self.cy_width;
}
@end
