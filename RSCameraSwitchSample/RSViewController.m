//
//  RSViewController.m
//  RSCameraSwitchSample
//
//  Created by R0CKSTAR on 11/26/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSViewController.h"

#import "RSCameraRotator.h"

@interface RSViewController () <RSCameraRotatorDelegate>

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
    
    RSCameraRotator *rotator = [[RSCameraRotator alloc] initWithFrame:CGRectMake(100, 100, 165, 50)];
    rotator.tintColor = [UIColor blackColor];
    rotator.offColor = [[self class] colorWithARGBHex:0xff498e14];
    rotator.onColorLight = [[self class] colorWithARGBHex:0xff9dd32a];
    rotator.onColorDark = [[self class] colorWithARGBHex:0xff66a61b];
    rotator.delegate = self;
    [self.view addSubview:rotator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clicked:(id)sender
{
    NSLog(@"sender = %@", [sender description]);
}

@end
