//
//  AnimationButton.m
//  AaronOC
//
//  Created by AaronYin on 2020/5/13.
//

#import "AnimationButton.h"
#import "UIView+Ext.h"
#import "CALayer+Ext.h"

@implementation AnimationButton

- (void)awakeFromNib {
    [super awakeFromNib];
    _enableShadow = NO;
    [self addTarget:self action:@selector(magnifyTransForm:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(renewTransForm:)   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchDragOutside];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _enableShadow = NO;
        [self addTarget:self action:@selector(magnifyTransForm:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(renewTransForm:)   forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchDragOutside];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _enableShadow = NO;
        [self addTarget:self action:@selector(magnifyTransForm:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(renewTransForm:)   forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchDragOutside];
    }
    return self;
}
- (instancetype)initWithBifFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _enableShadow = NO;
        [self addTarget:self action:@selector(magnifyTransBigForm:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(renewTransFormBig:)   forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(cancelTransForm:)  forControlEvents:UIControlEventTouchDragOutside];
    }
    return self;
}

- (void)magnifyTransForm:(UIButton *)btn{
    if (_enableShadow) {
        UIBezierPath* shadowPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(btn.size.height / 2.0f, btn.size.height / 2.0f)];
        btn.layer.shadowPath = shadowPath.CGPath;
        [[btn layer] setShadowOffset:CGSizeMake(0, 0)]; // 阴影的范围
        [[btn layer] setShadowRadius:4];                // 阴影扩散的范围控制
        [[btn layer] setShadowOpacity:1];               // 阴影透明度
        btn.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    }
    [UIView animateWithDuration:0.1 animations:^{
        btn.layer.transformScale = 0.95;
    }];
}

- (void)renewTransForm:(UIButton *)btn{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [btn.layer addAnimation:animation forKey:nil];
    [UIView animateWithDuration:0.02 animations:^{
        btn.layer.transformScale = 1;
    }];
    if (_enableShadow) {
        btn.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0].CGColor;
    }
    
}

- (void)renewTransFormBig:(UIButton *)btn{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [btn.layer addAnimation:animation forKey:nil];
    [UIView animateWithDuration:0.02 animations:^{
        btn.layer.transformScale = 1;
    }];
    if (_enableShadow) {
        btn.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0].CGColor;
    }
}

- (void)magnifyTransBigForm:(UIButton *)btn{
    if (_enableShadow) {
        UIBezierPath* shadowPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(btn.size.height / 2.0f, btn.size.height / 2.0f)];
        btn.layer.shadowPath = shadowPath.CGPath;
        [[btn layer] setShadowOffset:CGSizeMake(0, 0)]; // 阴影的范围
        [[btn layer] setShadowRadius:4];                // 阴影扩散的范围控制
        [[btn layer] setShadowOpacity:1];               // 阴影透明度
        btn.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    }
    [UIView animateWithDuration:0.1 animations:^{
        btn.layer.transformScale = 1.05;
    }];
}

+ (void)renewTransFormCell:(UIView *)view{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
    [UIView animateWithDuration:0.02 animations:^{
        view.layer.transformScale = 1;
    }];
    
}

- (void)cancelTransForm:(UIButton *)btn{
    if (_enableShadow) {
        btn.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0].CGColor;
    }
    [UIView animateWithDuration:0.1 animations:^{
        btn.layer.transformScale = 1;
    }];
}

- (void)tabBarButtonClick:(UIButton *)btn {
    [UIView animateWithDuration:0.1 animations:^{
        btn.layer.transformScale = 0.85;
    }];
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
}

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
}

@end
