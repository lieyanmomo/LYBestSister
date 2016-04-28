//
//  UIBarButtonItem+LYExtension.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/17.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LYExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
