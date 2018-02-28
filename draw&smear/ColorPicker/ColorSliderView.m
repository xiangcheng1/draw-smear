//
//  ColorSliderView.m
//  draw&smear
//
//  Created by 程翔 on 2018/2/28.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "ColorSliderView.h"

@interface ColorSliderView ()

@property (strong, nonatomic) UISlider *redSlider;
@property (strong, nonatomic) UISlider *greenSlider;
@property (strong, nonatomic) UISlider *blueSlider;

@property (strong, nonatomic) UITextField *redInput;
@property (strong, nonatomic) UITextField *greenInput;
@property (strong, nonatomic) UITextField *blueInput;
@end

@implementation ColorSliderView

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithRColor:255 GColor:0 BColor:0];
}

-(instancetype)initWithRColor:(CGFloat)rColor GColor:(CGFloat)gColor BColor:(CGFloat)bColor
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
        
        CGFloat currX = 50;
        CGFloat currY = 50;
        CGFloat slider_w = SCREEN_WIDTH / 2.0f;
        CGFloat slider_h = 40;
        for (int index = 0; index < 3; index ++) {
            
//            UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(currX, currY, <#CGFloat width#>, <#CGFloat height#>)];
            
        }
    }
    return self;
}


@end
