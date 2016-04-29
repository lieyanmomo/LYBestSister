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

#pragma mark - 初始化
- (void)awakeFromNib {
    // 设置cell背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

#pragma mark - 重写setFrame方法设置cell间距
-(void)setFrame:(CGRect)frame {
    frame.origin.y += LYMargin;
    frame.size.height -= LYMargin;
    [super setFrame:frame];
}

#pragma mark - 重写set方法赋值
- (void)setTopic:(LYTopic *)topic {
    _topic = topic;
    
    [self.profileImageView setHeaderImageWithURL:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    
    // 设置底部工具条按钮
    [self setUpButton:self.dingButton number:topic.ding title:@"顶"];
    [self setUpButton:self.caiButton number:topic.cai title:@"踩"];
    [self setUpButton:self.repostButton number:topic.repost title:@"转发"];
    [self setUpButton:self.commentButton number:topic.comment title:@"评论"];
}

/**
 *  设置底部工具栏按钮
 *
 *  @param button 按钮
 *  @param number 数字
 *  @param title  为0时显示的数字
 */
- (void)setUpButton:(UIButton *)button number:(NSInteger)number title:(NSString *)title {
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    }else if (number == 0){
        [button setTitle:title forState:UIControlStateNormal];
    }else {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }
}

#pragma mark - 点击cell上更多按钮
- (IBAction)moreClick:(id)sender {
    // iOS8开始
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"警告⚠️" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LYLog(@"点击了收藏按钮");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LYLog(@"点击了收藏举报");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        LYLog(@"点击了收藏取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
