//
//  RSCameraRotator.m
//  Greent
//
//  Created by R0CKSTAR on 11/23/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSCameraRotator.h"

#import <AVFoundation/AVFoundation.h>

@interface RSCameraRotator ()

@property (nonatomic) CGFloat cornerRadius;

@property (nonatomic, strong) UIButton *frontButton;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) CAGradientLayer *frontGradientLayer;

@property (nonatomic, strong) CAGradientLayer *backGradientLayer;

@end

@implementation RSCameraRotator

- (void)clicked:(UIButton *)sender shouldResetTheOtherButton:(BOOL)shouldReset
{
    [UIView animateWithDuration:0.3 animations:^{
        if (CATransform3DEqualToTransform(sender.layer.transform, CATransform3DIdentity)) {
            if (sender == self.frontButton) {
                sender.layer.transform = [self transformWithCameraPosition:AVCaptureDevicePositionFront];
            } else if (sender == self.backButton) {
                sender.layer.transform = [self transformWithCameraPosition:AVCaptureDevicePositionBack];
            }
            if (sender == self.backButton) {
                [self.backButton.layer insertSublayer:self.backGradientLayer below:self.backButton.imageView.layer];
            } else if (sender == self.frontButton) {
                [self.frontButton.layer insertSublayer:self.frontGradientLayer below:self.frontButton.imageView.layer];
            }
        } else {
            if (sender == self.backButton) {
                [self.backGradientLayer removeFromSuperlayer];
            } else if (sender == self.frontButton) {
                [self.frontGradientLayer removeFromSuperlayer];
            }
            sender.layer.transform = CATransform3DIdentity;
        }
    }];
    
    if (shouldReset) {
        [self clicked:(self.frontButton == sender ? self.backButton : self.frontButton) shouldResetTheOtherButton:NO];
    }
}

- (void)clicked:(UIButton *)sender
{
    [self clicked:sender shouldResetTheOtherButton:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clicked:)]) {
        BOOL isFront = NO;
        if ((CATransform3DEqualToTransform(sender.layer.transform, CATransform3DIdentity) && sender == self.backButton) || (!CATransform3DEqualToTransform(sender.layer.transform, CATransform3DIdentity) && sender == self.frontButton)) {
            isFront = YES;
        }
        [self.delegate clicked:isFront];
    }
}

- (CATransform3D)transformWithCameraPosition:(AVCaptureDevicePosition)cameraPosition
{
    CATransform3D transform = CATransform3DIdentity;
    if (cameraPosition == AVCaptureDevicePositionFront) {
        // Spin
        transform.m34 = 1.0 / -200.0;
    } else if (cameraPosition == AVCaptureDevicePositionBack) {
        // Spin
        transform.m34 = 1.0 / 200.0;
    }
    // Rotate
    transform = CATransform3DRotate(transform, M_PI_4/2.5, 0.0, 1.0, 0.0);
    // Scale
    transform = CATransform3DScale(transform, 0.9, 1, 1);
    return transform;
}

- (CAGradientLayer *)gradientLayerWithBounds:(CGRect)bounds
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[self.onColorLight CGColor],
                            (id)[self.onColorDark CGColor],
                            nil];
    return gradientLayer;
}

- (CAShapeLayer *)maskLayerWithCameraPosition:(AVCaptureDevicePosition)cameraPosition bounds:(CGRect)bounds
{
    UIBezierPath *maskPath = nil;
    if (cameraPosition == AVCaptureDevicePositionFront) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    } else if (cameraPosition == AVCaptureDevicePositionBack) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}

- (UIButton *)buttonWithCameraPosition:(AVCaptureDevicePosition)cameraPosition
{
    if (cameraPosition != AVCaptureDevicePositionUnspecified) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (cameraPosition == AVCaptureDevicePositionFront) {
            button.layer.anchorPoint = CGPointMake(1, 0.5);
            button.frame = CGRectMake(0, 0, (self.bounds.size.width / 2.0f), self.bounds.size.height);
            [button setImage:[UIImage imageNamed:@"front"] forState:UIControlStateNormal];
        } else if (cameraPosition == AVCaptureDevicePositionBack) {
            button.layer.anchorPoint = CGPointMake(0, 0.5);
            button.frame = CGRectMake((self.bounds.size.width / 2.0f), 0, (self.bounds.size.width / 2.0f), self.bounds.size.height);
            [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        }
        
        button.layer.mask = [self maskLayerWithCameraPosition:cameraPosition bounds:button.bounds];
        button.layer.transform = [self transformWithCameraPosition:cameraPosition];
        [button.layer insertSublayer:[self gradientLayerWithBounds:button.bounds] below:button.imageView.layer];
        
        if (cameraPosition == AVCaptureDevicePositionFront) {
            self.frontGradientLayer = button.layer.sublayers[0];
            self.frontGradientLayer.startPoint = CGPointMake(0, 0);
            self.frontGradientLayer.endPoint = CGPointMake(1, 0);
        } else if (cameraPosition == AVCaptureDevicePositionBack) {
            self.backGradientLayer = button.layer.sublayers[0];
            self.backGradientLayer.startPoint = CGPointMake(1, 0);
            self.backGradientLayer.endPoint = CGPointMake(0, 0);
        }
        [self addSubview:button];
        
        return button;
    }
    return nil;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius == cornerRadius) {
        return;
    }
    
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}

- (void)setOnColorLight:(UIColor *)onColorLight
{
    _onColorLight = onColorLight;
    
    if (self.frontGradientLayer) {
        self.frontGradientLayer.colors = [NSArray arrayWithObjects:
                                          (id)[onColorLight CGColor],
                                          (id)[self.onColorDark CGColor],
                                          nil];
    }
    
    if (self.backGradientLayer) {
        self.backGradientLayer.colors = [NSArray arrayWithObjects:
                                         (id)[onColorLight CGColor],
                                         (id)[self.onColorDark CGColor],
                                         nil];
    }
}

- (void)setOnColorDark:(UIColor *)onColorDark
{
    _onColorDark = onColorDark;
    
    if (self.frontGradientLayer) {
        self.frontGradientLayer.colors = [NSArray arrayWithObjects:
                                          (id)[self.onColorLight CGColor],
                                          (id)[onColorDark CGColor],
                                          nil];
    }
    
    if (self.backGradientLayer) {
        self.backGradientLayer.colors = [NSArray arrayWithObjects:
                                         (id)[self.onColorLight CGColor],
                                         (id)[onColorDark CGColor],
                                         nil];
    }
}

- (void)setOffColor:(UIColor *)offColor
{
    _offColor = offColor;
    self.layer.backgroundColor = [offColor CGColor];
    self.backButton.layer.backgroundColor = [offColor CGColor];
}

- (void)setDelegate:(id<RSCameraRotatorDelegate>)delegate
{
    _delegate = delegate;
    
    // Front is selected by default, when set delegate in controller, we send the default selection.
    if (_delegate && [_delegate respondsToSelector:@selector(clicked:)]) {
        [_delegate clicked:YES];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.onColorLight = [UIColor darkGrayColor];
        self.onColorDark = [UIColor lightGrayColor];
        self.offColor = [UIColor grayColor];
        
        self.cornerRadius = (frame.size.height / 2.0f);
        
        self.layer.backgroundColor = [self.offColor CGColor];
        
        if (!self.frontButton) {
            self.frontButton = [self buttonWithCameraPosition:AVCaptureDevicePositionFront];
        }
        
        if (!self.backButton) {
            self.backButton = [self buttonWithCameraPosition:AVCaptureDevicePositionBack];
            [self clicked:self.backButton shouldResetTheOtherButton:NO];
        }
    }
    return self;
}

@end
