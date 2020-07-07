//
//  ZZPhotoBrowser.h
//  AaronOC
//
//  Created by Aaron on 2020/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZPhotoBrowser : UIViewController

- (instancetype)initWithImage:(UIImage *)image;

- (instancetype)initWithImageURL:(NSURL *)URL;

- (void)setCloseButtonImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
