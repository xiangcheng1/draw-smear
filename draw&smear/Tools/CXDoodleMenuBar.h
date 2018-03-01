//
//  CXDoodleMenuBar.h
//  draw&smear
//
//  Created by 程翔 on 2018/3/1.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXDoodleMenuBarDelegate <NSObject>

- (void)doodleMenuBarClickIndex:(NSInteger)index barItemIsSelectAfter:(BOOL)select;

@end

@interface CXDoodleMenuBar : UIView

@property (nonatomic,weak) id<CXDoodleMenuBarDelegate> delegate;
@property (nonatomic,strong) UIColor * tintColor;
+ (instancetype)doodleMenuBarWithMenuButtonItemArray:(NSArray *)menuItemArray;
- (void)animationSHowDoodleMenuBarWithAnchorPoint:(CGPoint)anchorPoint;

@end

////////////////////////////////////////////////////////

@interface CXDoodleMenuButtonItem : NSObject

@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,strong) UIColor * normalColor;
@property (nonatomic,strong) UIColor * selectColor;
@property (nonatomic,assign) BOOL selected;
+ (instancetype)doodleMenuButtonItemWithImageName:(NSString *)imageName
                                 imageNormalColor:(UIColor *)normalColor
                                 imageSelectColor:(UIColor *)selectColor
                                       isSelected:(BOOL)selected;


@end

