//
//  SecondViewController.h
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionFromSecondToFirst.h"
@interface SecondViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic,strong) NSIndexPath *selectedCellIndexPath;
@end
