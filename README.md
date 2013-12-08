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
