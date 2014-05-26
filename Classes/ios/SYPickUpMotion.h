//
//  PickUpMotion.h
//  Vibin
//
//  Created by Sherlock on 3/20/14.
//  Copyright (c) 2014 Vibin, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  SYPickUpMotionFreeStyle = 0,          // Motion can move every where (default)
  SYPickUpMotionVerticalStyle = 1,      // Motion can only move vertically
  SYPickUpMotionVerticalFreeStyle = 2,  // Motion can trigger by vertical pan but move freely
  SYPickUpMotionHorizontalStyle = 3,    // Motion can only move horizontally
  SYPickUpMotionHorizontalFreeStyle = 4,// Motion can trigger by horizontally pan but move freely
} SYPickUpMotionStyle;

typedef enum {
  SYPickUpMotionAnimationFade = 0,    // Fade off the motion view when end (default)
  SYPickUpMotionAnimationFlyBack = 1, // Fly the motion view back to the picked view locatoin when end
  SYPickUpMotionAnimationFlyAway = 2, // Fly the motion view away from the picked view locatoin when end
} SYPickUpMotionAnimationType;

typedef enum {
  SYPickUpMotionDirectionLeft = 0,
  SYPickUpMotionDirectionUp = 1,
  SYPickUpMotionDirectionRight = 2,
  SYPickUpMotionDirectionDown = 3,
} SYPickUpMotionDirection;

@protocol SYPickUpMotionDelegate;
@protocol SYPickUpMotionDataSource;

/**
 * This motion class is used when you need to hold touch on an UIView element to pick it up,
 * then panning around the screen with the element stick to your finger.
 *
 * The motion class will take a snapshot of current panning view to move this gesture,
 * which makes it looks like its stick to the finger.
**/
@interface SYPickUpMotion : NSObject

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) UIView *view; // the motion(snapshot) view

@property (nonatomic, assign) SYPickUpMotionStyle style;
@property (nonatomic, assign) SYPickUpMotionAnimationType animationType;

@property (nonatomic, weak) id<SYPickUpMotionDelegate> delegate;
@property (nonatomic, weak) id<SYPickUpMotionDataSource> dataSource;

/**
 * Attach this motion to the view that need to be picked up.
**/
- (void)attachToView:(UIView *)view;

/**
 * Manually end motion by fade out
**/
- (void)fadeOut;
/**
 * Manually end motion by fly back
 **/
- (void)flyBack;

@end


@protocol SYPickUpMotionDelegate <NSObject>

@optional
- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion willBeginMoveView:(UIView *)view;
- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion didBeginMoveView:(UIView *)view;
/**
 * @param movement: x > 0 move right; x < 0 move left; y > 0 move down; y < 0 move up;
**/
- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion didMoveView:(UIView *)view withMovement:(CGPoint)movement;
- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion willEndMoveView:(UIView *)view withMovement:(CGPoint)movement;
- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion didEndMoveView:(UIView *)view withMovement:(CGPoint)movement;

// this method checks whehter you need the pickup view doing decelerate on specific direction
- (BOOL)pickUpmotion:(SYPickUpMotion *)pickUpmotion shouldDecelerateView:(UIView *)view inDirection:(SYPickUpMotionDirection)direction;

- (CGFloat)pickUpmotion:(SYPickUpMotion *)pickUpmotion viewAlphaForMovement:(CGPoint)movement;

@end


@protocol SYPickUpMotionDataSource <NSObject>

@required
/**
 * Should return the motion area view that the motion view can move around
**/
- (UIView *)containerViewOfPickUpmotion:(SYPickUpMotion *)pickUpmotion;

@optional
/**
 * Should return the frame of the given view in the container view
**/
- (CGRect)pickUpmotion:(SYPickUpMotion *)pickUpmotion frameOfView:(UIView *)view;

// default is 60
- (CGFloat)pickUpmotion:(SYPickUpMotion *)pickUpmotion maxDecelerateDistanceInDirection:(SYPickUpMotionDirection)direction;
// default is 200, bigger velocity means decelerate more slower
- (CGFloat)pickUpmotion:(SYPickUpMotion *)pickUpmotion decelerateVelocityInDirection:(SYPickUpMotionDirection)direction;

@end