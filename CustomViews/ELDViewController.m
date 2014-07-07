//
//  ELDViewController.m
//  CustomViews
//
//  Created by Gustavo Lima on 11/24/13.
//  Copyright (c) 2013 Gustavo Lima. All rights reserved.
//

#import "ELDViewController.h"

@interface ELDViewController ()

@end

@implementation ELDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bigCSlider.startColor = [UIColor yellowColor];
    self.bigCSlider.endColor = [UIColor redColor];
    self.bigCSlider.handleColor = [UIColor whiteColor];
    self.bigCSlider.circleColor = [UIColor lightGrayColor];
    self.bigCSlider.textColor = [UIColor redColor];
    self.bigCSlider.circleRadius = 70;
    self.bigCSlider.lineWidth = 30;
    
    self.smallCSlider.startColor = [UIColor greenColor];
    self.smallCSlider.endColor = [UIColor blueColor];
    self.smallCSlider.handleColor = [UIColor whiteColor];
    self.smallCSlider.circleColor = [UIColor blackColor];
    self.smallCSlider.textColor = [UIColor blueColor];
    self.smallCSlider.circleRadius = 30;
    self.smallCSlider.lineWidth = 15;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
