//
//  NSDate+LYExtension.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "NSDate+LYExtension.h"

@implementation NSDate (LYExtension)

/** 是否为昨天*/
- (BOOL)isYesterday {
    // 生成只有年月日的日期对象
    NSDateFormatter *fomt = [[NSDateFormatter alloc] init];
    fomt.dateFormat = @"yyyy-MM-dd"; // 日期格式
    
    NSString *selfString = [fomt stringFromDate:self];
    NSDate *selfDate = [fomt dateFromString:selfString];
    
    NSString *nowString = [fomt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fomt dateFromString:nowString];
    
    // 比较日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/** 是否为今天*/
- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return selfCmps.year == nowCmps.year
    && selfCmps.month == nowCmps.month
    && selfCmps.day == nowCmps.day;
}

/** 是否为明天*/
- (BOOL)isTomorrow {
    // 生成只有年月日的日期对象
    NSDateFormatter *fomt = [[NSDateFormatter alloc] init];
    fomt.dateFormat = @"yyyy-MM-dd"; // 日期格式
    
    NSString *selfString = [fomt stringFromDate:self];
    NSDate *selfDate = [fomt dateFromString:selfString];
    
    NSString *nowString = [fomt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fomt dateFromString:nowString];
    
    // 比较日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

/** 是否为今年*/
- (BOOL)isThisYear {
    // 获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return  selfYear == nowYear;
}

@end
