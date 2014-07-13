//
//  SecondViewController.m
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController()

@property (strong, nonatomic) ModelController *modelController;
@end


@implementation SecondViewController
@synthesize modelController = _modelController;
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
    self.colorViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.colorViewController.delegate = self;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.modelController = [[ModelController alloc]initWith:self.dataArray];
    ColorViewController *startingViewController = [self.modelController viewControllerAtIndex:self.currentCellIndexPath.row storyboard:storyboard];
    startingViewController.view.backgroundColor = (UIColor*)self.dataArray[self.currentCellIndexPath.row];
    NSArray *viewControllers = @[startingViewController];
    [self.colorViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.colorViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.colorViewController];
    [self.view addSubview:self.colorViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.colorViewController.view.frame = pageViewRect;
    
    [self.colorViewController didMoveToParentViewController:self];
    
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.colorViewController.gestureRecognizers;

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
#pragma mark - UIPageViewController Delegate

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        ColorViewController *currentViewController = self.colorViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.colorViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        self.colorViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    ColorViewController *currentViewController = (ColorViewController*)self.colorViewController.viewControllers[self.currentCellIndexPath.row];
    NSArray *viewControllers = nil;
    
    NSUInteger indexOfCurrentViewController = self.currentCellIndexPath.row;
    if (indexOfCurrentViewController == 0) {
        ColorViewController *nextViewController = [[ColorViewController alloc]init];
        nextViewController.view.backgroundColor = (UIColor*)[self.dataArray objectAtIndex:indexOfCurrentViewController+1];
        nextViewController.indexPath = [NSIndexPath indexPathForRow:self.currentCellIndexPath.row+1 inSection:self.currentCellIndexPath.section];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        ColorViewController *previousViewController = [[ColorViewController alloc]init];
        previousViewController.view.backgroundColor = (UIColor*)[self.dataArray objectAtIndex:indexOfCurrentViewController-1];
        previousViewController.indexPath = [NSIndexPath indexPathForRow:self.currentCellIndexPath.row-1 inSection:self.currentCellIndexPath.section];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.colorViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    return UIPageViewControllerSpineLocationMid;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{

    if (finished&&completed) {
        ColorViewController *currentVC = (ColorViewController*)[pageViewController.viewControllers firstObject];
        ColorViewController *previousVC = (ColorViewController*)[previousViewControllers firstObject];
        
        if (currentVC.indexPath.row>self.currentCellIndexPath.row) {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.currentCellIndexPath.row+1 inSection:self.currentCellIndexPath.section];
            self.currentCellIndexPath = newIndexPath;
            self.view.backgroundColor = (UIColor*)self.dataArray[newIndexPath.row];
        }
        if (currentVC.indexPath.row<self.currentCellIndexPath.row) {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.currentCellIndexPath.row-1 inSection:self.currentCellIndexPath.section];
            self.currentCellIndexPath = newIndexPath;
            self.view.backgroundColor = (UIColor*)self.dataArray[newIndexPath.row];
        }
    }
    
}


#pragma mark - panGestureRecognizer method


@end
