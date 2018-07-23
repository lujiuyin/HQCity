//
//  GravityView.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/17.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "GravityView.h"
#import <CoreMotion/CoreMotion.h>
#import "EllipseImageView.h"

@interface GravityView()
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) UIDynamicItemBehavior *item;

@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation GravityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[]];
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[]];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    self.item = [[UIDynamicItemBehavior alloc] initWithItems:@[]];
    self.item.elasticity = 0.5;
    
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
    [self.animator addBehavior:self.item];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1/60;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        double x = motion.gravity.x;
        double y = motion.gravity.y;
        double xy = atan2(x, y);
        self.gravity.angle = xy-M_PI_2;
    }];
    
    for (int i=0; i<50; i++) {
        [self createItem];
    }
}

- (void)createItem {
    int x = arc4random() % (int)self.frame.size.width;
    int size = self.bounds.size.width / 10;
    NSArray *imageArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    EllipseImageView *imageView = [[EllipseImageView alloc] initWithFrame:CGRectMake(x, size, size, size)];
    imageView.layer.cornerRadius = size/2;
    imageView.layer.masksToBounds = YES;
    imageView.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;
    imageView.image = [UIImage imageNamed:imageArray[arc4random() % imageArray.count]];
    [self addSubview:imageView];
    [self.item addItem:imageView];
    [self.gravity addItem:imageView];
    [self.collision addItem:imageView];
}
@end
