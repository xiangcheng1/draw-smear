//
//  ColorPickerView.h
//  draw&smear
//
//  Created by 程翔 on 2018/2/27.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerViewDelegate <NSObject>

- (void)pickerColor:(UIColor *)color;

@end

@interface ColorPickerView : UIView

/** imageView */
@property (nonatomic,strong) UIImageView * imgView;

/** 协议 */
@property (nonatomic,weak) id<ColorPickerViewDelegate> pickerColorDelegate;
@end
