//
//  PickUpMotion+Layout.m
//  Vibin
//
//  Created by Sherlock on 3/20/14.
//  Copyright (c) 2014 Vibin, Ltd. All rights reserved.
//

#import "SYPickUpMotion+Layout.h"
#import "SYPickUpMotion+Calculation.h"

@implementation SYPickUpMotion (Layout)

#pragma mark - Public Methods

- (void)pickUpView:(UIView *)pickedView {
  [self removeView]; // remove old view if needed
  
  UIImage *snapshot = [self imageWithView:pickedView];
  self.view = [[UIView alloc] initWithFrame:[self frameOfView:pickedView]];
  [self.view addSubview:[[UIImageView alloc] initWithImage:snapshot]];
  [self.view setBackgroundColor:pickedView.backgroundColor];
  [self.view.layer setMasksToBounds:YES];
  [[self.dataSource containerViewOfPickUpmotion:self] addSubview:self.view];
}

- (void)moveViewWithMovement:(CGPoint)movement fromPickedView:(UIView *)pickedView {
  self.view.center = [self centerOfView:pickedView withMovement:movement];
  if ([self.delegate respondsToSelector:@selector(pickUpmotion:viewAlphaForMovement:)]) {
    self.view.alpha = [self.delegate pickUpmotion:self viewAlphaForMovement:movement];
  }
}

- (void)removeView {
  if (self.view && self.view.superview) {
    [self.view removeFromSuperview];
  }
}

#pragma mark - Private Methods

- (UIImage *)imageWithView:(UIView *)view {
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@end
