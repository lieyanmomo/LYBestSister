//
//  LYTopicCenterView.h
//  LYBestSister
//
//  Created by 张海滨 on 16/5/6.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTopic;

@interface LYTopicCenterView : UIView
{
    // 属性
    __weak UIImageView *_imageView;
}

/** 中间控件创建方法 */
+ (instancetype)centerView;

/** 模型数据 */
@property (nonatomic, strong) LYTopic *topic;

@end
