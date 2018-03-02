//
//  CXSmearMenuBar.h
//  draw&smear
//
//  Created by 程翔 on 2018/3/1.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXSmearMenuBarDelegate <NSObject>

- (void)smearMenuBarClickIndex:(NSInteger)index barItemIsSelectAfter:(BOOL)select;

@end

@class CXSmearMenuButtonItem;
@interface CXSmearMenuBar : UIView

@property (nonatomic,weak) id<CXSmearMenuBarDelegate> delegate;
@property (nonatomic,strong) UIColor * tintColor;
+ (instancetype)smearMenuBarWithFrame:(CGRect)frame buttonItemArray:(NSArray <CXSmearMenuButtonItem *> *)menuItemArray;

@end

@interface CXSmearMenuButtonItem : NSObject

@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,strong) UIColor * normalColor;
@property (nonatomic,strong) UIColor * selectColor;
@property (nonatomic,assign) BOOL selected;
+ (instancetype)smearMenuButtonItemWithImageName:(NSString *)imageName
                                 imageNormalColor:(UIColor *)normalColor
                                 imageSelectColor:(UIColor *)selectColor
                                       isSelected:(BOOL)selected;

@end
