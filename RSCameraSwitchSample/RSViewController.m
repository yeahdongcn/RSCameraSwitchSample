//
//  RSViewController.m
//  RSCameraSwitchSample
//
//  Created by R0CKSTAR on 11/26/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSViewController.h"

#import "RSCameraSwitch.h"

@interface RSViewController () <RSCameraSwitchDelegate>

@property (nonatomic, strong) RSCameraSwitch *cameraSwitch;

@end

@implementation RSViewController

+ (UIColor *)colorWithARGBHex:(UInt32)hex
{
    int b = hex & 0x000000FF;
    int g = ((hex & 0x0000FF00) >> 8);
    int r = ((hex & 0x00FF0000) >> 16);
    int a = ((hex & 0xFF000000) >> 24);
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:a / 255.f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.cameraSwitch = [[RSCameraSwitch alloc] initWithFrame:CGRectMake(100, 100, 165, 50)];
    self.cameraSwitch.tintColor = [UIColor blackColor];
    self.cameraSwitch.offColor = [[self class] colorWithARGBHex:0xff498e14];
    self.cameraSwitch.onColorLight = [[self class] colorWithARGBHex:0xff9dd32a];
    self.cameraSwitch.onColorDark = [[self class] colorWithARGBHex:0xff66a61b];
    self.cameraSwitch.delegate = self;
    [self.view addSubview:self.cameraSwitch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clicked:(BOOL)isFront
{
    // When using GPUImage, put [self.videoCamera rotateCamera]; here,
    // Otherwise do:
    if (isFront) {
        NSLog(@"front button selected");
    } else {
        NSLog(@"back button selected");
    }
}

@end
