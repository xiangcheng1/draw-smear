//
//  ColorSliderView.h
//  draw&smear
//
//  Created by 程翔 on 2018/2/28.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorSliderViewDelegate <NSObject>

- (void)pickerColor:(UIColor *)color;

@end

@interface ColorSliderView : UIView

/** 协议 */
@property (nonatomic,weak) id<ColorSliderViewDelegate> sliderColorDelegate;

-(instancetype)initWithRColor:(CGFloat)rColor GColor:(CGFloat)gColor BColor:(CGFloat)bColor;

@end
