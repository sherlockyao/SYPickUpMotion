//
//  PickUpMotion+Calculation.m
//  Vibin
//
//  Created by Sherlock on 3/27/14.
//  Copyright (c) 2014 Vibin, Ltd. All rights reserved.
//

#import "SYPickUpMotion+Calculation.h"

#define TRIGGER_SENSITIVITY 1.3
#define DEFAULT_DECELERATE_VELOCITY 200
#define DEFAULT_MAX_DECELERATE_DISTANCE 60

@implementation SYPickUpMotion (Calculation)

#pragma mark - Public Methods

- (CGRect)frameOfView:(UIView *)view {
  if ([self.dataSource respondsToSelector:@selector(pickUpmotion:frameOfView:)]) {
    return [self.dataSource pickUpmotion:self frameOfView:view];
  } else {
    return view.frame;
  }
}

- (CGPoint)centerOfView:(UIView *)view withMovement:(CGPoint)movement {
  CGRect frame = [self frameOfView:view];
  CGSize size = frame.size;
  CGPoint center = frame.origin;
  center.x += (size.width / 2 + movement.x);
  center.y += (size.height / 2 + movement.y);
  return center;
}

- (CGPoint)centerOutOfScreenAgainstView:(UIView *)view {
  CGPoint againstCenter = [self centerOfView:view withMovement:CGPointZero];
  CGPoint currentCenter = self.view.center;
  CGPoint offset = CGPointMake(currentCenter.x - againstCenter.x, currentCenter.y - againstCenter.y);
  CGPoint newCenter = currentCenter;
  while (![self isCenterOffScreen:newCenter]) {
    newCenter.x += offset.x;
    newCenter.y += offset.y;
  }
  return newCenter;
}

- (CGPoint)locationOfGesture:(UIPanGestureRecognizer *)gesture {
  return [gesture locationInView:[self.dataSource containerViewOfPickUpmotion:self]];
}

- (CGPoint)movementOfGesture:(UIPanGestureRecognizer *)gesture fromLocation:(CGPoint)startLocation {
  CGPoint newLocation = [self locationOfGesture:gesture];
  CGPoint movement = CGPointMake(newLocation.x - startLocation.x, newLocation.y - startLocation.y);
  switch (self.style) {
    case SYPickUpMotionVerticalStyle:
      movement.x = 0;
      break;
      
    case SYPickUpMotionHorizontalStyle:
      movement.y = 0;
      break;
    
    case SYPickUpMotionFreeStyle:
    case SYPickUpMotionVerticalFreeStyle:
    case SYPickUpMotionHorizontalFreeStyle:
    default:
      break;
  }
  return movement;
}

- (CGPoint)decelerateMovement:(CGPoint)movement ofState:(SYPickUpMotionDecelerateState)decelerateState {
  if (decelerateState.needDecelerateVertical) {
    movement.y = [self decelerateDistanceOfOffset:movement.x inDirection:decelerateState.verticalDirection];
  }
  if (decelerateState.needDecelerateHorizontal) {
    movement.x = [self decelerateDistanceOfOffset:movement.x inDirection:decelerateState.horizontalDirection];
  }
  return movement;
}

- (SYPickUpMotionDecelerateState)decelerateStateOfView:(UIView *)view withMovement:(CGPoint)movement {
  SYPickUpMotionDecelerateState decelerateState;
  decelerateState.needDecelerateVertical = (0 != movement.y);
  decelerateState.needDecelerateHorizontal = (0 != movement.x);
  decelerateState.verticalDirection = (0 < movement.y ? SYPickUpMotionDirectionDown : SYPickUpMotionDirectionUp);
  decelerateState.horizontalDirection = (0 < movement.x ? SYPickUpMotionDirectionRight : SYPickUpMotionDirectionLeft);
  if ([self.delegate respondsToSelector:@selector(pickUpmotion:shouldDecelerateView:inDirection:)]) {
    decelerateState.needDecelerateVertical = decelerateState.needDecelerateVertical && [self.delegate pickUpmotion:self shouldDecelerateView:view inDirection:decelerateState.verticalDirection];
    decelerateState.needDecelerateHorizontal = decelerateState.needDecelerateHorizontal && [self.delegate pickUpmotion:self shouldDecelerateView:view inDirection:decelerateState.horizontalDirection];
  } else {
    // default is no decelerate
    decelerateState.needDecelerateVertical = NO;
    decelerateState.needDecelerateHorizontal = NO;
  }
  return decelerateState;
}

- (BOOL)shouldIgnoreGesture:(UIPanGestureRecognizer *)gesture {
  BOOL shouldIgnoreGesture = NO;
  CGPoint velocity = [gesture velocityInView:[self.dataSource containerViewOfPickUpmotion:self]];
  switch (self.style) {
    case SYPickUpMotionVerticalStyle:
    case SYPickUpMotionVerticalFreeStyle:
      shouldIgnoreGesture = ABS(velocity.x * TRIGGER_SENSITIVITY) > ABS(velocity.y);
      break;
      
    case SYPickUpMotionHorizontalStyle:
    case SYPickUpMotionHorizontalFreeStyle:
      shouldIgnoreGesture = ABS(velocity.y * TRIGGER_SENSITIVITY) > ABS(velocity.x);
      break;
      
    case SYPickUpMotionFreeStyle:
    default:
      break;
  }

  return shouldIgnoreGesture;
}

#pragma mark - Private Methods

- (BOOL)isCenterOffScreen:(CGPoint)center {
  CGSize halfSize = self.view.frame.size;
  halfSize.width /= 2;
  halfSize.height /= 2;
  if (center.x < -halfSize.width || center.x > [[UIScreen mainScreen] bounds].size.width + halfSize.width) {
    return YES;
  }
  if (center.y < -halfSize.height || center.y > [[UIScreen mainScreen] bounds].size.width + halfSize.height) {
    return YES;
  }
  return NO;
}

- (CGFloat)decelerateDistanceOfOffset:(CGFloat)offset inDirection:(SYPickUpMotionDirection)direction {
  CGFloat velocity = DEFAULT_DECELERATE_VELOCITY;
  CGFloat maxDistance = DEFAULT_MAX_DECELERATE_DISTANCE;
  if ([self.dataSource respondsToSelector:@selector(pickUpmotion:decelerateVelocityInDirection:)]) {
    velocity = [self.dataSource pickUpmotion:self decelerateVelocityInDirection:direction];
  }
  if ([self.dataSource respondsToSelector:@selector(pickUpmotion:maxDecelerateDistanceInDirection:)]) {
    maxDistance = [self.dataSource pickUpmotion:self maxDecelerateDistanceInDirection:direction];
  }
  maxDistance = maxDistance * (0 > offset ? -1 : 1);
  offset = velocity < abs(offset) ? velocity : abs(offset);
  return maxDistance * (1 - powf((velocity - offset) / velocity, 2));
}

@end
