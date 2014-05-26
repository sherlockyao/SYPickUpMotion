//
//  PickUpMotion+Layout.h
//  Vibin
//
//  Created by Sherlock on 3/20/14.
//  Copyright (c) 2014 Vibin, Ltd. All rights reserved.
//

#import "SYPickUpMotion.h"

@interface SYPickUpMotion (Layout)

/**
 * Take a snapshot of picked view to create motion view, then add it to container view
**/
- (void)pickUpView:(UIView *)pickedView;

/**
 * Move the motion view to new location based on the movement from the picked view
**/
- (void)moveViewWithMovement:(CGPoint)movement fromPickedView:(UIView *)pickedView;

- (void)removeView;

@end
