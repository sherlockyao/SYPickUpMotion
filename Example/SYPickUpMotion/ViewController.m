//
//  ViewController.m
//  SYPickUpMotion
//
//  Created by Sherlock on 5/26/14.
//
//

#import "ViewController.h"
#import "SYPickUpMotion.h"

@interface ViewController () <SYPickUpMotionDataSource, SYPickUpMotionDelegate>

@property (weak, nonatomic) IBOutlet UIView *movingView;
@property (strong, nonatomic) SYPickUpMotion *pickUpMotion;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configurePickUpMotion];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - PickUpMotion

- (UIView *)containerViewOfPickUpmotion:(SYPickUpMotion *)pickUpmotion {
  return self.view;
}

- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion willBeginMoveView:(UIView *)view {
}

- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion didBeginMoveView:(UIView *)view {
  view.hidden = YES;
}

- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion didMoveView:(UIView *)view withMovement:(CGPoint)movement {
}

- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion willEndMoveView:(UIView *)view withMovement:(CGPoint)movement {
}

- (void)pickUpmotion:(SYPickUpMotion *)pickUpmotion didEndMoveView:(UIView *)view withMovement:(CGPoint)movement {
  view.hidden = NO;
}


#pragma mark - Private Method

- (void)configurePickUpMotion {
  self.pickUpMotion = [SYPickUpMotion new];
  self.pickUpMotion.style = SYPickUpMotionFreeStyle;
  self.pickUpMotion.animationType = SYPickUpMotionAnimationFlyBack;
  self.pickUpMotion.delegate = self;
  self.pickUpMotion.dataSource = self;
  
  [self.pickUpMotion attachToView:self.movingView];
}

@end
