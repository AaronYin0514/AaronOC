//
//  ZZPhotoBrowser.m
//  AaronOC
//
//  Created by Aaron on 2020/7/7.
//

#import "ZZPhotoBrowser.h"
#import "AnimationButton.h"
#import "GHDevice.h"

@interface ZZPhotoBrowser () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) AnimationButton *closeButton;

@end

@implementation ZZPhotoBrowser

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.imageView.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tap];
    [self.view addSubview:self.closeButton];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.scrollView.contentSize.width == self.scrollView.frame.size.width) {
        [self.scrollView setZoomScale:2.0 animated:YES];
    } else {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
}

- (void)setCloseButtonImage:(UIImage *)image {
    [self.closeButton setImage:image];
}

- (void)closeAction:(UIButton *)sender {
    [self dismissAction];
}

- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, GHDevice.defaultDevice.screenWidth, GHDevice.defaultDevice.screenHeight)];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GHDevice.defaultDevice.screenWidth, GHDevice.defaultDevice.screenHeight)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (AnimationButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[AnimationButton alloc] initWithFrame:CGRectMake(8, GHDevice.defaultDevice.statusBarHeight + 2, 40, 40)];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
