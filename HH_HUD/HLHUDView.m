//
//  HLHUDView.m
//  HuLuWorld
//
//  Created by 黄华 on 2018/1/15.
//  Copyright © 2018年 huanghua. All rights reserved.
//

#import "HLHUDView.h"
#import "CommenHeader.h"

#define HUDMargin 20

@interface HLHUDView()
{
    UIView  *_toastView;
    UILabel *_msgLabel;
    UIImageView *_imgView;
    BOOL    _isShow;
}

@end


@implementation HLHUDView

static id toastHUD;

+ (instancetype)shareHUD{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toastHUD = [[HLHUDView alloc] init];
    });
    return toastHUD;
}



- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName{
    [self initWithText:text withImgview:imgName duration:0];
}

- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName offSetY:(CGFloat)offsetY{
    [self initWithText:text withImgview:imgName duration:0 offSetY:offsetY];
}

- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName duration:(NSInteger)duration{
    [self initWithText:text withImgview:imgName duration:duration offSetY:0];
}

- (void)initWithText:(NSString *)text withImgview:(NSString *)imgName duration:(NSInteger)duration offSetY:(CGFloat)offsetY{
    
    if(_isShow) return;
    
    if(text == nil || text == NULL || [text isKindOfClass:[NSNull class]] || [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        return;
    }
    
    if(duration < 1.f) duration = 1.f;
    
    _isShow = YES;
    
    /****************************** == MsgLabel  == ********************************/
    _msgLabel = [[UILabel alloc] init];
    [_msgLabel setTextAlignment:NSTextAlignmentCenter];
    [_msgLabel setText:text];
    [_msgLabel setNumberOfLines:0];
    [_msgLabel setTextColor:UIColorFromRGB(0X2d2d2d)];
    [_msgLabel setFont:[UIFont systemFontOfSize:14]];
    
    /****************************** == _imgView == ********************************/
    _imgView = [[UIImageView alloc] init];
    _imgView.contentMode =  UIViewContentModeScaleAspectFill;
    _imgView.image = [UIImage imageNamed:imgName];
    
    /****************************** == ToastView == ********************************/
    _toastView = [[UIView alloc] init];
    [_toastView setBackgroundColor:UIColorFromRGB(0Xffe301)];
    [_toastView.layer setCornerRadius:6.f];
    [_toastView setClipsToBounds:YES];
//    [_toastView setAlpha:0.9f];
    
    [_toastView addSubview:_imgView];
    [_toastView addSubview:_msgLabel];
    
    /****************************** == Arrt == ********************************/
    
    NSDictionary *attrs = @{NSFontAttributeName:[_msgLabel font]};
    CGSize size = [text boundingRectWithSize:CGSizeMake(KScreenwidth - HUDMargin,KScreenheight - HUDMargin) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    CGPoint CenterPoint;
    if(offsetY <= 0 || offsetY >= KScreenheight){
        CenterPoint = (CGPoint){KScreenwidth * 0.5,KScreenheight * 0.5};
    }else{
        CenterPoint = (CGPoint){KScreenwidth * 0.5,offsetY + size.height};
    }
    
    _toastView.bounds = (CGRect){CGPointZero,{size.width + HUDMargin*3,size.height + HUDMargin*4}};
    _toastView.center = CenterPoint;
    
//    _imgView.bounds = (CGRect){CGPointZero,{_imgView.image.size.width,_imgView.image.size.height}};
//    _imgView.center = CenterPoint;
//    _msgLabel.bounds = (CGRect){CGPointZero,{size.width,size.height}};
//    _msgLabel.center = (CGPoint){(size.width * 0.5 + HUDMargin * 0.5),(size.height * 0.5 + HUDMargin * 0.5)};
    
    CGFloat x = _toastView.bounds.size.width;
    CGFloat itme_w = _imgView.image.size.width;
    CGFloat itme_h = _imgView.image.size.height;
    
    _imgView.frame = CGRectMake((x-itme_w)/2, 20, itme_w, itme_h);
    _msgLabel.frame = CGRectMake((x-size.width)/2, kB(_imgView)+10, size.width, size.height);
    

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_toastView];
    
    [[NSOperationQueue mainQueue]  addOperationWithBlock:^{
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:duration];
    }];
}

- (void)dismiss{
    _isShow = NO;
    [_toastView removeFromSuperview];
}

@end
