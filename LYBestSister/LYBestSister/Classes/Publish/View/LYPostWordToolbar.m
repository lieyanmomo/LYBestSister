//
//  LYPostWordToolbar.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/15.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPostWordToolbar.h"

@implementation LYPostWordToolbar

+ (instancetype)toolbarFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
