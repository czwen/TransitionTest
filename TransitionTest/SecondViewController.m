//
//  SecondViewController.m
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[ViewController class]]) {
        return [[TransitionFromSecondToFirst alloc]init];
    }
    return nil;
}

// pan gestrue method
- (void)didPan:(UIPanGestureRecognizer*)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.frame.size.width * 1.0);
    //progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"%f",progress);
    
    [self panState:recognizer.state progress:progress];
}

- (void)panState:(UIGestureRecognizerState)state progress:(CGFloat)progress
{
    [self panToRight];

    switch (state) {
        case UIGestureRecognizerStateBegan:
            if (progress>0) {
                //from left to right
                self.interactivePopTransition = [UIPercentDrivenInteractiveTransition new];
                [self panToRight];
            }
            if (progress<0) {
                //from right to left
                self.interactivePopTransition = [UIPercentDrivenInteractiveTransition new];
                [self panToLeft];
            }
            break;
        case UIGestureRecognizerStateChanged:
            [self.interactivePopTransition updateInteractiveTransition:abs(progress)];
            break;
        case UIGestureRecognizerStateEnded:
            [self.interactivePopTransition finishInteractiveTransition];
            break;
        default:
            break;
    }
}

- (void)panToLeft
{
    
}

- (void)panToRight
{
    NSLog(@"%@",self.selectedCellIndexPath);
    //last color
    UIColor *previousColor;
    if (self.selectedCellIndexPath.row-1<0) {
        NSLog(@"it's first object");
    }else{
        previousColor = (UIColor*)[self.dataArray objectAtIndex:self.selectedCellIndexPath.row-1];
    }
    
    //current color view
    UIView *currentView = [self.view snapshotViewAfterScreenUpdates:NO];
    //previousColor color view
    UIView *previousView = [self.view snapshotViewAfterScreenUpdates:NO];
    previousView.backgroundColor = previousColor;
    previousView.frame = CGRectMake(-currentView.frame.size.width, previousView.frame.origin.y, previousView.frame.size.width, previousView.frame.size.height);
    //add subview
    [self.view addSubview:previousView];
    [self.view addSubview:currentView];
    //config frame
    CGRect currentViewFinalFrame= CGRectMake(currentView.frame.size.width*2, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
    CGRect previousViewFinalFrame = currentView.frame;
    [UIView animateWithDuration:1
                     animations:^{
                         currentView.transform = CGAffineTransformMakeTranslation(currentViewFinalFrame.origin.x, currentViewFinalFrame.origin.y);
                         previousView.transform = CGAffineTransformMakeTranslation(previousViewFinalFrame.origin.x,previousViewFinalFrame.origin.y);
                     }
                     completion:^(BOOL finished) {
                         self.view.backgroundColor = previousColor;
                         [currentView removeFromSuperview];
                         [previousView removeFromSuperview];
                         NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.selectedCellIndexPath.row-1 inSection:self.selectedCellIndexPath.section];
                         self.selectedCellIndexPath = newIndexPath;
                     }];
}


@end
