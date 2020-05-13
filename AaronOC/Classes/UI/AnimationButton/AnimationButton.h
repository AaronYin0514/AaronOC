//
//  AnimationButton.h
//  AaronOC
//
//  Created by AaronYin on 2020/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationButton : UIButton

@property (nonatomic) BOOL enableShadow;
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)magnifyTransForm:(UIButton *)btn;
- (void)renewTransForm:(UIButton *)btn;
- (void)cancelTransForm:(UIButton *)btn;
- (void)tabBarButtonClick:(UIButton *)btn;
+ (void)renewTransFormCell:(UIView *)view;
- (instancetype)initWithBifFrame:(CGRect)frame;

- (void)setTitle:(NSString *)title;

- (void)setTitleColor:(UIColor *)titleColor;

- (void)setImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
