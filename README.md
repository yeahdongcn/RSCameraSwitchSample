RSCameraSwitchSample
====================

A pure code implementation of http://dribbble.com/shots/929359-Camera-Switch

The image below is what this control looks in dribbble

![ScreenShot](http://d13yacurqjgara.cloudfront.net/users/2637/screenshots/929359/camera-button.png)

and this is what my control looks like 

![ScreenShot](https://s3.amazonaws.com/cocoacontrols_production/uploads/control_image/image/2335/iOS_Simulator_Screen_shot_Nov_26__2013__10.24.14_AM.png)

similar but still have some difference in material.

Usage, creation:

    self.rotator = [[RSCameraRotator alloc] initWithFrame:CGRectMake(100, 100, 165, 50)];
    self.rotator.tintColor = [UIColor blackColor];
    self.rotator.offColor = [[self class] colorWithARGBHex:0xff498e14];
    self.rotator.onColorLight = [[self class] colorWithARGBHex:0xff9dd32a];
    self.rotator.onColorDark = [[self class] colorWithARGBHex:0xff66a61b];
    self.rotator.delegate = self;
    [self.view addSubview:self.rotator];
    
event handling:

    - (void)clicked:(UIButton *)sender
    {
        // When using GPUImage, put [self.videoCamera rotateCamera]; here,
        // otherwise, handle sender separetely.
        if (!CATransform3DEqualToTransform(sender.layer.transform, CATransform3DIdentity)) {
            if (sender == self.rotator.backButton) {
                NSLog(@"back button selected");
            } else if (sender == self.rotator.frontButton) {
                NSLog(@"front button selected");
            }
        } else {
            if (sender == self.rotator.backButton) {
                NSLog(@"front button selected");
            } else if (sender == self.rotator.frontButton) {
                NSLog(@"back button selected");
            }
        }
    }
