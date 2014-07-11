//
//  TransitionFromFirstToSecond.m
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import "TransitionFromFirstToSecond.h"
@implementation TransitionFromFirstToSecond

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ViewController *fromVC = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];

    UICollectionViewCell *selectedCell = [fromVC.collectionView cellForItemAtIndexPath:[fromVC.collectionView.indexPathsForSelectedItems firstObject]];
    
    UICollectionViewCell *selectedCellSnap = (UICollectionViewCell*)[selectedCell snapshotViewAfterScreenUpdates:NO];
    
    selectedCellSnap.frame = [containerView convertRect:selectedCell.frame fromView:selectedCell.superview];
    
                                              
    [containerView addSubview:selectedCellSnap];

    //selectedCell.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect screen = [[UIScreen mainScreen]bounds];
        selectedCellSnap.frame = screen;
    } completion:^(BOOL finished) {
        [containerView addSubview:toVC.view];
        toVC.view.backgroundColor = selectedCell.backgroundColor;
        [selectedCellSnap removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        //selectedCell.hidden = NO;
    }];
    

}
@end
