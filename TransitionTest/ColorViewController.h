//
//  ColorViewController.h
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/11/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface ColorViewController : UIPageViewController<UINavigationControllerDelegate>
@property (nonatomic,strong) NSIndexPath *selectedCellIndexPath;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end
