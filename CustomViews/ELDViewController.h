//
//  ELDViewController.h
//  CustomViews
//
//  Created by Gustavo Lima on 11/24/13.
//  Copyright (c) 2013 Gustavo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleSlider.h"

@interface ELDViewController : UIViewController

@property (weak, nonatomic) IBOutlet CircleSlider *bigCSlider;
@property (weak, nonatomic) IBOutlet CircleSlider *smallCSlider;

@end
