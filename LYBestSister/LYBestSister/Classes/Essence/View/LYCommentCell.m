//
//  LYCommentCell.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/13.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYCommentCell.h"
#import "LYComment.h"
#import "LYUser.h"


@interface LYCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation LYCommentCell

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - 重写set方法
- (void)setComment:(LYComment *)comment {
    _comment = comment;
    
//    if (arc4random_uniform(100) > 50) {
//            comment.voicetime = arc4random_uniform(60);
//            comment.voiceuri = @"http://123.mp3";
//            comment.content = nil;
//        }
    
    [self.profileImageView setHeaderImageWithURL:comment.user.profile_image];
    NSString *sexImageName = [comment.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" :@"Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImageName];
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    self.contentLabel.text = comment.content;
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

@end
