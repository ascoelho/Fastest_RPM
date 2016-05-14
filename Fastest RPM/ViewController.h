//
//  ViewController.h
//  Fastest RPM
//
//  Created by Anthony Coelho on 2016-05-14.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property  CGFloat currVelocity ;
@property  CGFloat maxVelocity;
@property (weak, nonatomic) IBOutlet UIImageView *needleView;


@property CGAffineTransform minRotationTransform;


- (void)movedNeedleWithVelocity: (CGFloat)velocity;


@end

