//
//  ViewController.h
//  TransitionTest
//
//  Created by Chen ZhiWen on 7/10/14.
//  Copyright (c) 2014 Chen Zhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RandomColor.h"
#import "TransitionFromFirstToSecond.h"
@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
