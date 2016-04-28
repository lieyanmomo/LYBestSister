//
//  LYTopicCell.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTopic;

@interface LYTopicCell : UITableViewCell

/** 帖子模型数据*/
@property (strong, nonatomic) LYTopic *topic;

@end
