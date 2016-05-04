//
//  LYTopic.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopic.h"
#import "LYComment.h"
#import "LYUser.h"

@implementation LYTopic

#pragma mark - MJExtension
/** 声明模型属性名 对应的字典key*/
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{
//             @"top_cmt" : @"top_cmt[0]"
//             };
//}


#pragma mark - 重写get方法
- (NSString *)created_at {
    // 服务器返回的日期
    NSDateFormatter *fomt = [[NSDateFormatter alloc] init];
    fomt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fomt dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 当前时间
            NSDate *nowDate = [NSDate date];
            // 获取日历对象
            NSCalendar *calender = [NSCalendar currentCalendar];
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calender components:unit fromDate:createdAtDate toDate:nowDate options:0];
            if (cmps.hour >= 1) { // 一小时前
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if (cmps.minute >= 1) { // 一分钟前
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }else {
                return @"刚刚";
            }
            
        }else if (createdAtDate.isYesterday){ // 昨天
            fomt.dateFormat = @"昨天 HH:mm:ss";
            return [fomt stringFromDate:createdAtDate];
        }else{ // 其他
            fomt.dateFormat = @"MM-dd HH:mm:ss";
            return [fomt stringFromDate:createdAtDate];
        }
    }else{ // 非今年
        return _created_at;
    }
}

#pragma mark - 计算cellHeight和centerViewFrame
- (CGFloat)cellHeight {
    // 如果已经计算过cell的高度直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字
    CGFloat textY = 55;
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * LYMargin; // 最大长度
    // 文字高度
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight = textY + textH + LYMargin;
    
    // 有中间内容
    if (self.type != LYTopicTypeWord) {
        // 中间控件的X
        CGFloat centerViewX = LYMargin;
        // 中间控件Y
        CGFloat centerViewY = textY + textH + LYMargin;
        // 中间控件宽
        CGFloat centerViewW = textMaxW;
        // 中间控件高
        CGFloat centerViewH = self.height * centerViewW / self.width;
        if (centerViewH >= [UIScreen mainScreen].bounds.size.height) {
            centerViewH = 200;
            self.bigPicture = YES;
        }
        _centerViewFrame = CGRectMake(centerViewX, centerViewY, centerViewW, centerViewH);
        _cellHeight += centerViewH + LYMargin;
        
    }
    
    // 有最热评论
    if (self.top_cmt) {
        CGFloat TopCmtTitleH = 20;
        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
        // 最热评论内容高度
        CGFloat topCmtTextH = [topCmtText boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight += TopCmtTitleH + topCmtTextH + LYMargin;
    }
    
    // 底部工具条
    CGFloat toolBarH = 35;
    _cellHeight += toolBarH + LYMargin;
    
    
    return _cellHeight;
}

@end
