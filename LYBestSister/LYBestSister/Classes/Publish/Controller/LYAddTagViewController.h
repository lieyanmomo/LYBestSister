//
//  LYAddTagViewController.h
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/16.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYAddTagViewController : UIViewController

/** 传递tag数据的block, block的参数是一个字符串数组 */
@property (nonatomic, copy) void (^getTagsBlock)(NSArray *);

/** 从上一个界面传递过来的标签数据 */
@property (nonatomic, strong) NSArray *tags;


@end
