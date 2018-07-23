//
//  EmitterView.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "EmitterView.h"

@implementation EmitterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"white"].CGImage);
    cell.birthRate = 2000;
    cell.lifetime = 5.0;
    cell.lifetimeRange = 0.3;
    cell.alphaRange = 0.5;
    cell.alphaSpeed = -0.2;
    cell.velocity = 40;
    cell.velocityRange = 20;
    
    cell.redRange = 0.5;
    cell.greenRange = 0.5;
    cell.blueRange = 0.5;
    
    cell.scale = 0.2;
    cell.scaleRange = 0.02;
    
    cell.emissionLongitude = M_PI;
//    cell.yAcceleration = 70.0;
    
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    layer.emitterPosition = CGPointMake(self.bounds.size.width/2, 100);
    layer.birthRate = 10000;
    layer.emitterSize = CGSizeMake(self.bounds.size.width, 0);
    layer.emitterShape = kCAEmitterLayerSphere;
    layer.emitterMode = kCAEmitterLayerOutline;
    
    layer.renderMode = kCAEmitterLayerUnordered;
    
    layer.zPosition = -1;
    layer.emitterCells = @[cell];
    [self.layer addSublayer:layer];
}
@end
