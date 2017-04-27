//
//
//  Created by yangye on 14-10-14.
//  Copyright (c) 2014年. All rights reserved.
//

#import "GWCustomerAlertView.h"

@interface GWCustomerAlertView ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, copy)dispatch_block_t complementBlock;
@property (nonatomic, copy)dispatch_block_t dismissFinishBlock;

@end

@implementation GWCustomerAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initWithData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initWithData];
    }
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self initWithData];
    }
    
    return self;
}

//默认设置
- (void)initWithData
{
    self.scale = kScreenWidth;
    self.alertViewH = 160 * self.scale;
    self.alertViewW = 310 * self.scale;
    _touchOutSideIsDismiss = NO;
}

- (CGFloat)locationY {
    
    if (_locationY == 0.0) {
        
        return (self.bgView.bounds.size.height - self.alertViewH) / 2.0;
    }
    return _locationY;
}

- (CGFloat)locationX {
    
    if (_locationX == 0.0) {
        
        return (self.bgView.bounds.size.width - self.alertViewW)/2.0;
    }
    return _locationX;
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.bgView = topVC.view;
    self.frame = CGRectMake(self.locationX, self.locationY, self.alertViewW, self.alertViewH);
    [topVC.view addSubview:self];
}

- (void)showInView:(UIView *)aView
{
    self.bgView = aView;
    self.frame = CGRectMake(self.locationX, self.locationY, self.alertViewW, self.alertViewH);
    [aView addSubview:self];
}

- (void)dismissAlert:(dispatch_block_t)dismissFinishBlock
{
    self.dismissFinishBlock = dismissFinishBlock;
    
    [self removeFromSuperview];
}

- (void)dismissAlert{
    
    [self dismissAlert:NULL];
}

- (void)removeFromSuperview
{
    if (self.popStyle == Style_PopFromCenter)
    {
        [UIView animateWithDuration:0.05f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.backgroundView.alpha = 0.1;
            self.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            
            [super removeFromSuperview];
            
            [self.backgroundView removeFromSuperview];
            self.backgroundView = nil;
            
            //恢复alpha
            self.alpha = 1.0;
            
            if (self.dismissFinishBlock) {
                self.dismissFinishBlock();
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:0.15 animations:^{
            
            self.backgroundView.alpha = 0.1;
            self.frame = CGRectMake(self.locationX, self.bgView.bounds.size.height, self.alertViewW, self.alertViewH);
            
        } completion:^(BOOL finished) {
            [super removeFromSuperview];
            
            [self.backgroundView removeFromSuperview];
            self.backgroundView = nil;
            
            if (self.dismissFinishBlock) {
                self.dismissFinishBlock();
            }
        }];
    }
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    
    if (!self.backgroundView)
    {
        self.backgroundView = [[UIView alloc] initWithFrame:self.bgView.bounds];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.70];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.bgView addSubview:self.backgroundView];
        
        if (self.touchOutSideIsDismiss)
        {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [self.backgroundView addGestureRecognizer:tapGesture];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    
    CGRect afterFrame = CGRectMake(self.locationX, self.locationY, self.alertViewW, self.alertViewH);

    [self moveAnimationWithDuration:0.15 complementBlock:^{
        weakSelf.frame = afterFrame;
    }];
    
    [super willMoveToSuperview:newSuperview];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture
{
    [self dismissAlert:nil];
}

#pragma mark -Animation

- (void)moveAnimationWithDuration:(NSTimeInterval)duration complementBlock:(void (^)(void))complementBlock
{
    if (self.popStyle == Style_PopFromCenter)
    {
        self.complementBlock = complementBlock;
        
        CAKeyframeAnimation* keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        keyFrameAnimation.delegate = self;
        keyFrameAnimation.duration = duration;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        keyFrameAnimation.values = values;
        [self.layer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation"];
    }
    else
    {
        __weak typeof(self) weakSelf = self;
        
        CGRect beforeFram = CGRectMake(self.locationX, self.bgView.bounds.size.height, self.alertViewW, self.alertViewH);
        self.frame = beforeFram;
        
        CGRect afterFrame = CGRectMake(self.locationX, self.locationY, self.alertViewW, self.alertViewH);

        [UIView animateWithDuration:duration animations:^{
            weakSelf.frame = afterFrame;
            
        } completion:^(BOOL finished) {
            complementBlock();
        }];
    }
}

/* Called when the animation begins its active duration. */
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.complementBlock) {
        self.complementBlock();
    }
}

#pragma mark -private
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end

