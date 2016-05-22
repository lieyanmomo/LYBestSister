//
//  LYPostWordToolbar.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/15.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPostWordToolbar.h"
#import "LYNavigationController.h"
#import "LYAddTagViewController.h"

@interface LYPostWordToolbar ()


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

/** 所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;

/** 加号按钮 */
@property (nonatomic, weak) UIButton *addButton;

@end

@implementation LYPostWordToolbar

#pragma mark - 懒加载
- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    
    return _tagLabels;
}


/** 创建xib的类方法 */
+ (instancetype)toolbarFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


#pragma mark - 初始化
- (void)awakeFromNib {
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    // 监听【点击】
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:addButton];
    
    self.addButton = addButton;
    
    // 默认传递2个标签
    [self createTagLabels:@[@"吐槽", @"糗事"]];
}

#pragma mark - 监听

#pragma mark -- 点击【加号按钮】
- (void)addClick {
    
    __weak typeof(self) weakSelf = self;
    
    LYAddTagViewController *addTagC = [[LYAddTagViewController alloc] init];
    
    addTagC.getTagsBlock = ^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    };
    addTagC.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    LYNavigationController *nagivationC = [[LYNavigationController alloc] initWithRootViewController:addTagC];
    
    // 获得【窗口根控制器】曾经modal出【发表文字】的导航控制器
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    [vc presentViewController:nagivationC animated:YES completion:nil];
    
}

#pragma mark - 创建label
- (void)createTagLabels:(NSArray *)tags {
    // 移除所有的label
    //    for (UILabel *label in self.tagLabels) {
    //        [label removeFromSuperview];
    //    }
    // 让self.tagLabels数组中的所有对象执行removeFromSuperview方法
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    // 所有的标签label
    for (int i = 0; i < tags.count; i++) {
        // 创建label
        UILabel *newTagLabel = [[UILabel alloc] init];
        newTagLabel.text = tags[i];
        newTagLabel.font = [UIFont systemFontOfSize:14];
        newTagLabel.backgroundColor = [UIColor grayColor];
        newTagLabel.textColor = [UIColor whiteColor];
        newTagLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:newTagLabel];
        [self.tagLabels addObject:newTagLabel];
        
        // 尺寸
        [newTagLabel sizeToFit];
        newTagLabel.height = LYTagH;
        newTagLabel.width += 2 * LYMargin;
        
    
    }
    
    // 重新布局子控件
    [self setNeedsLayout];

}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    // 所有的标签label
    for (int i = 0; i < self.tagLabels.count; i++) {
        // 创建label
        UILabel *newTagLabel = self.tagLabels[i];
        
        // 位置
        if (i == 0) {
            newTagLabel.x = 0;
            newTagLabel.y = 0;
        } else {
            // 上一个标签
            UILabel *previousTagLabel = self.tagLabels[i - 1];
            CGFloat leftWidth = CGRectGetMaxX(previousTagLabel.frame) + LYMargin;
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= newTagLabel.width) {
                newTagLabel.x = leftWidth;
                newTagLabel.y = previousTagLabel.y;
            } else {
                newTagLabel.x = 0;
                newTagLabel.y = CGRectGetMaxY(previousTagLabel.frame) + LYMargin;
            }
        }
    }
    
    // 加号按钮
    UILabel *lastTagLabel = self.tagLabels.lastObject;
    if (lastTagLabel) {
        CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LYMargin;
        CGFloat rightWidth = self.topView.width - leftWidth;
        if (rightWidth >= self.addButton.width) {
            self.addButton.x = leftWidth;
            self.addButton.y = lastTagLabel.y;
        } else {
            self.addButton.x = 0;
            self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + LYMargin;
        }
    } else {
        self.addButton.x = 0;
        self.addButton.y = 0;
    }
    
    // 计算工具条的高度
    self.topViewHeight.constant = CGRectGetMaxY(self.addButton.frame);
    CGFloat oldHeight = self.height;
    self.height = self.topViewHeight.constant + self.bottomView.height + LYMargin;
    self.y += oldHeight - self.height;
    
}


@end
