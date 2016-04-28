//
//  LYTopic.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopic.h"

@implementation LYTopic

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

@end
