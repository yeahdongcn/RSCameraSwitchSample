RSCameraSwitchSample
====================

A pure code implementation of http://dribbble.com/shots/929359-Camera-Switch

The image below is what this control looks in dribbble

![ScreenShot](https://d13yacurqjgara.cloudfront.net/users/2637/screenshots/929359/camera-button.png)

and this is what my control looks like 

![ScreenShot](https://s3.amazonaws.com/cocoacontrols_production/uploads/control_image/image/2335/iOS_Simulator_Screen_shot_Nov_26__2013__10.24.14_AM.png)

similar but still have some difference in material.

Usage, creation:

    self.cameraSwitch = [[RSCameraSwitch alloc] initWithFrame:CGRectMake(100, 100, 165, 50)];
    self.cameraSwitch.tintColor = [UIColor blackColor];
    self.cameraSwitch.offColor = [[self class] colorWithARGBHex:0xff498e14];
    self.cameraSwitch.onColorLight = [[self class] colorWithARGBHex:0xff9dd32a];
    self.cameraSwitch.onColorDark = [[self class] colorWithARGBHex:0xff66a61b];
    self.cameraSwitch.delegate = self;
    [self.view addSubview:self.cameraSwitch];
    
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


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/yeahdongcn/rscameraswitchsample/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

