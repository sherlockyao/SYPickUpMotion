//
//  PickUpMotion+Calculation.h
//  Vibin
//
//  Created by Sherlock on 3/27/14.
//  Copyright (c) 2014 Vibin, Ltd. All rights reserved.
//

#import "SYPickUpMotion.h"

typedef struct {
  SYPickUpMotionDirection verticalDirection;
  BOOL needDecelerateVertical;
  SYPickUpMotionDirection horizontalDirection;
  BOOL needDecelerateHorizontal;
} SYPickUpMotionDecelerateState;

@interface SYPickUpMotion (Calculation)

/**
 * The frame of view in the container area, usually its the origin picked up view
**/
- (CGRect)frameOfView:(UIView *)view;

/**
 * The new center position of view in the container area with a certain movement
**/
- (CGPoint)centerOfView:(UIView *)view withMovement:(CGPoint)movement;

/**
 * The new center position make the current motion view off screen with the direction against to the given view(usually the picked view)
**/
- (CGPoint)centerOutOfScreenAgainstView:(UIView *)view;

- (CGPoint)locationOfGesture:(UIPanGestureRecognizer *)gesture;

- (CGPoint)movementOfGesture:(UIPanGestureRecognizer *)gesture fromLocation:(CGPoint)startLocation;

- (CGPoint)decelerateMovement:(CGPoint)movement ofState:(SYPickUpMotionDecelerateState)decelerateState;

- (SYPickUpMotionDecelerateState)decelerateStateOfView:(UIView *)view withMovement:(CGPoint)movement;

- (BOOL)shouldIgnoreGesture:(UIPanGestureRecognizer *)gesture;

@end
