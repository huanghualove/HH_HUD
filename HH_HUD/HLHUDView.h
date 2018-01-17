//
//  HLHUDView.h
//  HuLuWorld
//
//  Created by 黄华 on 2018/1/15.
//  Copyright © 2018年 huanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLHUDView : UIView

+ (instancetype)shareHUD;

- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName;
- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName offSetY:(CGFloat)offsetY;

- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName duration:(NSInteger)duration;
- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName duration:(NSInteger)duration offSetY:(CGFloat)offsetY;

@end
