//
//  LYTopicCell.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopicCell.h"
#import "LYTopic.h"

@interface LYTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation LYTopicCell


#pragma mark - 重写set方法赋值
- (void)setTopic:(LYTopic *)topic {
    _topic = topic;
    
    [self.profileImageView setHeaderImageWithURL:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd", topic.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd", topic.cai] forState:UIControlStateNormal];
    [self.repostButton setTitle:[NSString stringWithFormat:@"%zd", topic.cai] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd", topic.comment] forState:UIControlStateNormal];
}

@end
