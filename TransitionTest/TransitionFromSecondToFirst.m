//
//  TransitionFromSecondToFirst.m
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import "TransitionFromSecondToFirst.h"

@implementation TransitionFromSecondToFirst

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SecondViewController *fromVC = (SecondViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UICollectionViewCell *selectedCell = [toVC.collectionView cellForItemAtIndexPath:fromVC.selectedCellIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    
    fromVC.view.frame = [containerView convertRect:fromVC.view.frame fromView:containerView];
    
    [containerView addSubview:toVC.view];
    
    [containerView addSubview:fromVC.view];
    
    CGRect selectedCellFrame = [selectedCell.superview convertRect:selectedCell.frame toView:toVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = selectedCellFrame;
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
