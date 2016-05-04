//
//  LYTopicPictureView.h
//  LYBestSister
//
//  Created by 张海滨 on 16/5/4.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTopic;

@interface LYTopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子模型 */
@property (nonatomic, strong) LYTopic *topic;

@end
