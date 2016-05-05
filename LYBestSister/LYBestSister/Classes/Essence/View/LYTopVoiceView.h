//
//  LYTopVoiceView.h
//  LYBestSister
//
//  Created by 张海滨 on 16/5/5.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTopic;

@interface LYTopVoiceView : UIView

+ (instancetype)voiceView;

/** 模型数据 */
@property (nonatomic, strong) LYTopic *topic;

@end
