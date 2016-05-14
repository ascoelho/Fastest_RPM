//
//  ViewController.m
//  Fastest RPM
//
//  Created by Anthony Coelho on 2016-05-14.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "ViewController.h"

#define RADIANS(degrees)    (((degrees) * M_PI) / 180.0)
#define MIN_DEGREES         -135.0
#define MAX_DEGREES         135.0
#define RANGE_DEGREES       (MAX_DEGREES - MIN_DEGREES)

#define LIMIT_VELOCITY      7500.0  //points per second
#define LIMIT_VELOCITY_DELTA 10.0   //points per second

#define RESET_DELAY         0.1     //seconds
#define VELOCITY_DELAY      0.1     //seconds


@interface ViewController ()





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.needleView.transform = CGAffineTransformRotate(self.needleView.transform, RADIANS(MIN_DEGREES));
    self.minRotationTransform = self.needleView.transform;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fingerMoved:)];
    
    [self.view addGestureRecognizer:pan];
}

- (void)fingerMoved:(UIPanGestureRecognizer *)pan {
    CGPoint componentVelocity = [pan velocityInView:self.view];
    CGFloat velocity = sqrt(pow(componentVelocity.x, 2) + pow(componentVelocity.y, 2));
    
    [self movedNeedleWithVelocity:velocity];
    
    //After the gesture state changes to ended, failed or cancelled, move the needle back to base position
    //After the gesture state changes to ended, failed or cancelled, move the needle back to base position
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed || pan.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:1.0 delay:RESET_DELAY options:UIViewAnimationOptionCurveEaseIn
                         animations:^(void) {

                             self.needleView.transform = CGAffineTransformMakeRotation(RADIANS(MIN_DEGREES));
                             
                         }
                         completion:^(BOOL finished){}];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)movedNeedleWithVelocity:(CGFloat)velocity {
    
    self.currVelocity = velocity;
    
    //calculate velocity of pan motion
    self.maxVelocity = MAX(self.maxVelocity, velocity);
    
    //calculate proportion of current velocity to velocity limit
    CGFloat velocityProportion = velocity / LIMIT_VELOCITY;
    
    //calculate proportion of RPM needle degree range
    CGFloat degrees = MIN(RANGE_DEGREES * velocityProportion, RANGE_DEGREES);
    
    //move needle in degree range proportionate to velocity
    self.needleView.transform = CGAffineTransformRotate(self.minRotationTransform, RADIANS(degrees));
    
}

@end
