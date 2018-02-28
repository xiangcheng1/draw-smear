//
//  MyImageView.h
//  draw&smear
//
//  Created by 程翔 on 2018/2/27.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIImageView

/*
 * 记录 开始时候的图片 就是为了填充时候图片
 */
@property (nonatomic,strong) UIImage * baseImage;

/*
 * 当前需要填充的颜色
 */
@property (nonatomic,strong) UIColor * newcolor;

/*
 * 多个撤销点
 */
@property (nonatomic,strong) NSMutableArray * revokePoints;

/*
 * 缩放比例
 */
@property (nonatomic,assign) CGFloat scaleNum;

/*
 * 撤销操作
 */
- (void)revokeOption;

@end
