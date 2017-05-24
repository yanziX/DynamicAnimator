//
//  CYDynamicController.m
//  DynamicAnimator
//
//  Created by storm on 2017/5/24.
//  Copyright © 2017年 strom. All rights reserved.
//

#import "CYDynamicController.h"
#import "UIView+extension.h"

@interface CYDynamicController ()

{
    CGPoint weiInitialPoint;
    CGPoint wanInitialPoint;
    CGPoint daiInitialPoint;
    CGPoint xuInitialPoint;
}

@property (nonatomic, strong) UIImageView *weiImageView;
@property (nonatomic, strong) UIImageView *wanImageView;
@property (nonatomic, strong) UIImageView *daiImageView;
@property (nonatomic, strong) UIImageView *xuImageView;
@property (nonatomic, strong) UIImageView *longmaoImageView;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation CYDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self animation];

}

- (void)initSubViews {
    [self.view addSubview:self.weiImageView];
    [self.view addSubview:self.wanImageView];
    [self.view addSubview:self.daiImageView];
    [self.view addSubview:self.xuImageView];
    [self.view addSubview:self.longmaoImageView];
    
    _weiImageView.cy_originY = -100;
    _wanImageView.cy_originY = -100;
    _daiImageView.cy_originY = -100;
    _xuImageView.cy_originY = -100;
    
}

- (void)animation {
    
    //实现龙猫的晃动动画，设置龙猫不间断晃动
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(-20 / 180.0 * M_PI), @(10 / 180.0 * M_PI), @(-20 /180.0 * M_PI)];
    animation.removedOnCompletion = NO;
    animation.duration = 0.5;
    animation.repeatCount = MAXFLOAT;
    [self.longmaoImageView.layer addAnimation:animation forKey:nil];
    
    
    //设置四个ImageView的吸附动画，由初始位置吸附到各个ImageView的center位置，每个ImageView 的路径不一样
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:_weiImageView snapToPoint:weiInitialPoint];
    snap.damping = 1.0;
    
    UISnapBehavior *snap1 = [[UISnapBehavior alloc] initWithItem:_wanImageView snapToPoint:wanInitialPoint];
    snap1.damping = 1.0;
    
    UISnapBehavior *snap2 = [[UISnapBehavior alloc] initWithItem:_daiImageView snapToPoint:daiInitialPoint];
    snap2.damping = 1.0;
    
    UISnapBehavior *snap3 = [[UISnapBehavior alloc] initWithItem:_xuImageView snapToPoint:xuInitialPoint];
    snap3.damping = 1.0;
    
    
    //重力效果，声明一个对象，可以循环加载
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:_weiImageView];
    [gravity addItem:_wanImageView];
    [gravity addItem:_daiImageView];
    [gravity addItem:_xuImageView];
    
    //弹性效果，这里设置碰撞类型collisionMode为碰撞所有
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    [collision addItem:_weiImageView];
    [collision addItem:_wanImageView];
    [collision addItem:_daiImageView];
    [collision addItem:_xuImageView];
    
    
    //初始化 self.animator，self.animator的ReferenceView是所有子类View的父View，承载所有动画
    //snap吸附动画的发生通过线程设置延时，展现出的效果有节奏
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animator addBehavior:snap];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animator addBehavior:snap1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animator addBehavior:snap2];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animator addBehavior:snap3];
    });
}



- (UIImageView *)longmaoImageView {
    if (!_longmaoImageView) {
        _longmaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"longmao"]];
        _longmaoImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - kDistanceWidthRatio(100), kDistanceHeightRatio(640), kDistanceWidthRatio(200), kDistanceWidthRatio(200));
        _longmaoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _longmaoImageView;
}

- (UIImageView *)weiImageView {
    if (!_weiImageView) {
        _weiImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wei"]];
        _weiImageView.frame = CGRectMake(kDistanceWidthRatio(200), kDistanceHeightRatio(500), kDistanceWidthRatio(60), kDistanceWidthRatio(60));
        weiInitialPoint = _weiImageView.cy_center;
    }
    return _weiImageView;
}

- (UIImageView *)wanImageView {
    if (!_wanImageView) {
        _wanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wan"]];
        _wanImageView.frame = CGRectMake(_weiImageView.cy_rightX + kDistanceWidthRatio(20), kDistanceHeightRatio(400), kDistanceWidthRatio(100), kDistanceWidthRatio(100));
        wanInitialPoint = _wanImageView.cy_center;
    }
    return _wanImageView;
}

- (UIImageView *)daiImageView {
    if (!_daiImageView) {
        _daiImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dai"]];
        _daiImageView.frame = CGRectMake(_wanImageView.cy_rightX + kDistanceWidthRatio(20), kDistanceHeightRatio(460), kDistanceWidthRatio(60), kDistanceWidthRatio(60));
        daiInitialPoint = _daiImageView.cy_center;
    }
    return _daiImageView;
}

- (UIImageView *)xuImageView {
    if (!_xuImageView) {
        _xuImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xu"]];
        _xuImageView.frame = CGRectMake(_daiImageView.cy_rightX + kDistanceWidthRatio(20), kDistanceHeightRatio(500), kDistanceWidthRatio(100), kDistanceWidthRatio(100));
        xuInitialPoint = _xuImageView.cy_center;
    }
    return _xuImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
