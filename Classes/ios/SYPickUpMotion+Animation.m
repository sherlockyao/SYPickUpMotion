//
//  PickUpMotion+Animation.m
//  Vibin
//
//  Created by Sherlock on 3/27/14.
//  Copyright (c) 2014 Vibin, Ltd. All rights reserved.
//

#import "SYPickUpMotion+Animation.h"
#import "SYPickUpMotion+Calculation.h"

@implementation SYPickUpMotion (Animation)

- (void)animateViewWithPickedView:(UIView *)pickedView completion:(void (^)(BOOL finished))completion {
  switch (self.animationType) {
    case SYPickUpMotionAnimationFlyBack:
      [self flyBackToView:pickedView completion:completion];
      break;
    
    case SYPickUpMotionAnimationFlyAway:
      [self flyAwayFromView:pickedView completion:completion];
      break;
      
    case SYPickUpMotionAnimationFade:
    default:
      [self fadeOutWithCompletion:completion];
      break;
  }
}

- (void)fadeOutWithCompletion:(void (^)(BOOL finished))completion {
  [UIView animateWithDuration:0.25 animations:^{
    self.view.alpha = 0;
  } completion:completion];
}

- (void)flyBackToView:(UIView *)view completion:(void (^)(BOOL finished))completion {
  CGPoint center = [self centerOfView:view withMovement:CGPointZero];
  [UIView animateWithDuration:0.25 animations:^{
    self.view.center = center;
    self.view.alpha = 1;
  } completion:completion];
}

- (void)flyAwayFromView:(UIView *)view completion:(void (^)(BOOL finished))completion {
  CGPoint center = [self centerOutOfScreenAgainstView:view];
  [UIView animateWithDuration:0.25 animations:^{
    self.view.center = center;
  } completion:completion];
}

@end
