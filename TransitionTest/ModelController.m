//
//  ModelController.m
//  TransitionTest
//
//  Created by ChenZhiWen on 7/12/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import "ModelController.h"

@interface ModelController()

@property (strong, nonatomic) NSArray *pageData;
@end

@implementation ModelController

- (id)initWith:(NSArray*)data
{
    self = [super init];
    if (self) {
        // Create the data model.
        self.pageData = data;
    }
    return self;
}

- (ColorViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ColorViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"ColorViewController"];
    dataViewController.view.backgroundColor = (UIColor*)self.pageData[index];
    return dataViewController;
}
- (ColorViewController *)viewControllerWithIndexPath:(NSIndexPath*)indexPath storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (indexPath.row == [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ColorViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"ColorViewController"];
    dataViewController.view.backgroundColor = (UIColor*)self.pageData[indexPath.row];
    dataViewController.indexPath = indexPath;
    return dataViewController;
}
- (NSUInteger)indexOfViewController:(ColorViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.color];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //to right
    SecondViewController *secondVC = (SecondViewController*)pageViewController.parentViewController;
    NSUInteger index = secondVC.currentCellIndexPath.row;
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    //return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
    return [self viewControllerWithIndexPath:[NSIndexPath indexPathForRow:index inSection:secondVC.currentCellIndexPath.section] storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //to left
    SecondViewController *secondVC = (SecondViewController*)pageViewController.parentViewController;
    NSUInteger index = secondVC.currentCellIndexPath.row;
    
    index++;
    
    if (index == [self.pageData count]) {
        return nil;
    }
    //return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
    return [self viewControllerWithIndexPath:[NSIndexPath indexPathForRow:index inSection:secondVC.currentCellIndexPath.section] storyboard:viewController.storyboard];

}

@end
