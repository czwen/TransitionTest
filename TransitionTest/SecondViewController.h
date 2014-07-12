//
//  SecondViewController.h
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionFromSecondToFirst.h"
#import "ColorViewController.h"
#import "ModelController.h"
typedef enum {left=0, right} direction;
@interface SecondViewController : UIViewController<UINavigationControllerDelegate,UIPageViewControllerDelegate>
@property (nonatomic,strong) NSIndexPath *currentCellIndexPath;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIPageViewController *colorViewController;
@property (nonatomic) direction dirc;
@end
