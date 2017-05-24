//
//  CYComprehensiveController.m
//  动画Demo
//
//  Created by storm on 2017/5/19.
//  Copyright © 2017年 strom. All rights reserved.
//

#import "CYComprehensiveController.h"
#import "UIImage+GIF.h"
#import "UIView+extension.h"

@interface CYComprehensiveController ()
{
    CGPoint xingPoint;
    CGPoint bikePoint;
    CGPoint paobuPoint;
    CGPoint outPoint;
}


@property (nonatomic, strong) UIImageView *bgImageView; //背景
@property (nonatomic, strong) UIImageView *bikeImageView; //骑
@property (nonatomic, strong) UIImageView *xingImageView;  //行
@property (nonatomic, strong) UIImageView *paobuImageView; //跑步已OUT
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *nowImageView;
@property (nonatomic, strong) UIImageView *personImageView;
@property (nonatomic, strong) UIImageView *mountainImageView;

@property (nonatomic,strong)UIImageView* outImageView;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation CYComprehensiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
}

- (void)addSubViews {
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.paobuImageView];
    [self.bgImageView addSubview:self.bikeImageView];
    [self.bgImageView addSubview:self.xingImageView];
    [self.bgImageView addSubview:self.logoImageView];
    [self.bgImageView addSubview:self.nowImageView];
    [self.bgImageView addSubview:self.personImageView];
    [self.bgImageView addSubview:self.mountainImageView];
    [self.bgImageView addSubview:self.outImageView];
    
    _paobuImageView.cy_bottomY = 0;
    _bikeImageView.cy_rightX = 0;
    _xingImageView.cy_originX = SCREEN_WIDTH;
    _outImageView.cy_bottomY = -200;
    _nowImageView.alpha = 0;
    _personImageView.alpha = 0;
}



/**
 * 展示动画效果
 
 * UIDynamicAnimator 是UIKit动力学动画效果
 * UISnapBehavior 吸附动画
 * UIGravityBehavior  重力效果
 * UICollisionBehavior 弹性效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI * 2);
    anima.duration = 1.0f;
    anima.repeatCount = CGFLOAT_MAX;
    
    [_logoImageView.layer addAnimation:anima forKey:nil];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.bgImageView];
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:_paobuImageView snapToPoint:paobuPoint];
    snap.damping = 0.8;
    
    UISnapBehavior *snap2 = [[UISnapBehavior alloc] initWithItem:_bikeImageView snapToPoint:bikePoint];
    snap2.damping = 0.8;
    
    UISnapBehavior *snap3 = [[UISnapBehavior alloc] initWithItem:_xingImageView snapToPoint:xingPoint];
    snap3.damping = 0.8;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:_outImageView];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    [collisionBehavior addItem:_xingImageView];
    [collisionBehavior addItem:_outImageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_animator addBehavior:snap2];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_animator addBehavior:snap3];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_animator addBehavior:snap];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_animator addBehavior:gravityBehavior];
        [_animator addBehavior:collisionBehavior];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:3.f animations:^{
            _nowImageView.alpha = 1;
            _personImageView.alpha = 1;
        } completion:^(BOOL finished) {
            _bgImageView.userInteractionEnabled = YES;
        }];
    });
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImageView.image = [UIImage imageNamed:@"welcome_background"];
    }
    return _bgImageView;
}

- (UIImageView *)bikeImageView {
    if (!_bikeImageView) {
        _bikeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDistanceWidthRatio(140), self.paobuImageView.cy_bottomY + kDistanceHeightRatio(32), kDistanceWidthRatio(162), kDistanceHeightRatio(220))];
        bikePoint = _bikeImageView.cy_center;
        _bikeImageView.image = [UIImage imageNamed:@"welcome_ride"];
    }
    return _bikeImageView;
}

- (UIImageView *)xingImageView {
    if (!_xingImageView) {
        
        _xingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDistanceWidthRatio(162), kDistanceHeightRatio(220))];
        _xingImageView.cy_rightX = SCREEN_WIDTH-kDistanceWidthRatio(140);
        _xingImageView.cy_originY = self.bikeImageView.cy_originY;
        _xingImageView.image = [UIImage imageNamed:@"welcome_xing"];
        xingPoint = _xingImageView.cy_center;
    }
    return _xingImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bikeImageView.cy_rightX + kDistanceWidthRatio(12), 0, kDistanceWidthRatio(122), kDistanceWidthRatio(122))];
        _logoImageView.cy_centerY = self.bikeImageView.cy_centerY;
        _logoImageView.image = [UIImage imageNamed:@"welcome_logo"];
    }
    return _logoImageView;
}

- (UIImageView *)nowImageView {
    if (!_nowImageView) {
        _nowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDistanceWidthRatio(347), kDistanceHeightRatio(71))];
        _nowImageView.cy_originY = self.bikeImageView.cy_bottomY + kDistanceHeightRatio(92);
        _nowImageView.cy_centerX = SCREEN_HEIGHT / 2;
        _nowImageView.image = [UIImage imageNamed:@"welcome_atTime"];
    }
    return _nowImageView;
}

- (UIImageView *)personImageView {
    if (!_personImageView) {
        NSString *gifName = @"p1_gif.gif";
        NSString *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:gifName ofType:nil];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        
        _personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDistanceWidthRatio(540), kDistanceHeightRatio(450))];
        _personImageView.cy_originY = self.nowImageView.cy_bottomY + kDistanceHeightRatio(102);
        _personImageView.cy_centerX = SCREEN_WIDTH / 2;
        _personImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    }
    return _personImageView;
}

- (UIImageView *)paobuImageView {
    if (!_paobuImageView) {
        _paobuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDistanceWidthRatio(161), kDistanceHeightRatio(190), kDistanceWidthRatio(223), kDistanceHeightRatio(81))];
        _paobuImageView.image = [UIImage imageNamed:@"welcome_runed"];
        paobuPoint = _paobuImageView.cy_center;
    }
    return _paobuImageView;
}

- (UIImageView *)mountainImageView {
    if (!_mountainImageView) {
        _mountainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDistanceHeightRatio(148))];
        _mountainImageView.cy_originY = SCREEN_HEIGHT - kDistanceHeightRatio(148) - kDistanceHeightRatio(374);
        _mountainImageView.image = [UIImage imageNamed:@"welcome_jiashan"];
    }
    return _mountainImageView;
}

- (UIImageView *)outImageView {
    if (!_outImageView) {
        _outImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDistanceWidthRatio(269), kDistanceHeightRatio(170))];
        _outImageView.image = [UIImage imageNamed:@"welcome_OUT"];
        _outImageView.cy_originY = kDistanceHeightRatio(134);
        _outImageView.cy_rightX = SCREEN_WIDTH - kDistanceWidthRatio(90);
        outPoint = _outImageView.cy_center;
    }
    return _outImageView;
}

- (NSString *)controllerTitle {
    return @"综合案例";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
