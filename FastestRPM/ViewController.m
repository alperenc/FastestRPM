//
//  ViewController.m
//  FastestRPM
//
//  Created by Alp Eren Can on 03/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *needleContainerView;
@property (weak, nonatomic) IBOutlet UILabel *highestVelocityLabel;

@property (nonatomic) float velocity;
@property (nonatomic) int highestVelocity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.highestVelocity = 0;
    
    [self setNeedleToOriginalPosition];
}

- (IBAction)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint velocityInCGPoint = [sender velocityInView:self.view];
        
        self.velocity = sqrtf(powf(velocityInCGPoint.x, 2) + powf(velocityInCGPoint.y, 2));
        
        float maxVelocity = 2000.0;
        
        self.needleContainerView.transform = CGAffineTransformMakeRotation( -1.25 * M_PI + (self.velocity / maxVelocity  * (270.0 / 360.0) * M_PI));
        if (self.velocity > self.highestVelocity) {
            self.highestVelocity = (int)self.velocity;
        }
        
        if (self.velocity >= maxVelocity) {
            self.needleContainerView.transform = CGAffineTransformMakeRotation(90.0 / 360.0 * M_PI);
        }
        
    } else {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(setNeedleToOriginalPosition) userInfo:nil repeats:NO];
        
    }
    
    self.highestVelocityLabel.text = [NSString stringWithFormat:@"Highest velocity is: %d", self.highestVelocity];
}
                          
- (void)setNeedleToOriginalPosition {
  self.needleContainerView.transform = CGAffineTransformMakeRotation(-1.25 * M_PI);
    self.highestVelocityLabel.text = [NSString stringWithFormat:@"Highest velocity is: %d", self.highestVelocity];
}

@end
