//
//  RSCameraSwitch.h
//  RSCameraSwitchSample
//
//  Created by R0CKSTAR on 11/23/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSCameraSwitchDelegate <NSObject>

@optional

- (void)clicked:(BOOL)isFront;

@end

@interface RSCameraSwitch : UIView

@property (nonatomic, readonly) UIButton *frontButton;

@property (nonatomic, readonly) UIButton *backButton;

@property (nonatomic, strong) UIColor *offColor;

@property (nonatomic, strong) UIColor *onColorLight;

@property (nonatomic, strong) UIColor *onColorDark;

@property (nonatomic, assign) id<RSCameraSwitchDelegate> delegate;

@end
