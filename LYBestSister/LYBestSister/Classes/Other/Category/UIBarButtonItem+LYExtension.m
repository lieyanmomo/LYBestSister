//
//  UIBarButtonItem+LYExtension.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/17.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "UIBarButtonItem+LYExtension.h"

@implementation UIBarButtonItem (LYExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [settingButton sizeToFit];
    [settingButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:settingButton];
}
@end
