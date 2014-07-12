//
//  ModelController.h
//  TransitionTest
//
//  Created by ChenZhiWen on 7/12/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorViewController.h"
#import "SecondViewController.h"
@interface ModelController : NSObject<UIPageViewControllerDataSource>
- (id)initWith:(NSArray*)data;
- (ColorViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(ColorViewController *)viewController;

@end
