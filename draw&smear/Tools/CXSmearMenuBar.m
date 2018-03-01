//
//  CXSmearMenuBar.m
//  draw&smear
//
//  Created by 程翔 on 2018/3/1.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "CXSmearMenuBar.h"
#import "CXShineButton.h"

static CGFloat const KToolBarItemSize = 30;

@interface CXSmearMenuBar ()

@property (nonatomic,strong) NSArray * menuItemArray;

@end

@implementation CXSmearMenuBar

+(instancetype)smearMenuBarWithFrame:(CGRect)frame buttonItemArray:(NSArray<CXSmearMenuButtonItem *> *)menuItemArray
{
    CXSmearMenuBar * bar = [[CXSmearMenuBar alloc] initWithFrame:frame];
    bar.menuItemArray = menuItemArray;
    return bar;
}

#pragma mark - private methods
- (void)addMenuButtonItem
{
//    // Bar item button frame
//    @weakify(self);
//    CGFloat barItemPadding = (SCREEN_WIDTH - self.menuItemArray.count * KToolBarItemSize)/(self.menuItemArray.count + 1);
//    [self.menuItemArray enumerateObjectsUsingBlock:^(CXSmearMenuButtonItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
//        @strongify(self);
//        UIImage *normalImage = [[UIImage imageNamed:item.imageName] imageWithTintColor:item.normalColor];
//        UIImage *selectImage = [[UIImage imageNamed:item.imageName] imageWithTintColor:item.selectColor];
//        CXShineButton *btn = [CXShineButton shineButtonWithTintColor:item.selectColor normalImage:normalImage hightlightImage:selectImage normarTypeTapAction:^{
//            [self.delegate smearMenuBarClickIndex:idx barItemIsSelectAfter:YES];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self p_animateToDismissMenuBar];
//            });
//        } hightlightTypeTapAction:^{
//            [self.delegate smearMenuBarClickIndex:idx barItemIsSelectAfter:NO];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self p_animateToDismissMenuBar];
//            });
//        }];
//        btn.isCycleResponse = YES;
//
//        [self addSubview:btn];
//        [self.menuBarButtonItemArray addObject:btn];
//
//        CGFloat btnCenterX = toolBarEndFrame.origin.x + (barItemPadding + KToolBarItemSize/2) * (idx + 1) + idx * KToolBarItemSize/2;
//        CGPoint center = CGPointMake(btnCenterX, toolBarStartCenter.y);
//        btn.center = center;
//        btn.bounds = CGRectMake(0, 0, KToolBarItemSize, KToolBarItemSize);
//        btn.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.01, 0.01), CGAffineTransformMakeTranslation(-20, KToolBarHeight/2));
//    }];
    
}


#pragma mark - setting
-(void)setMenuItemArray:(NSArray *)menuItemArray
{
    _menuItemArray = menuItemArray;
    if (_menuItemArray.count > 0) {
        [self addMenuButtonItem];
    }
}




@end


////////////////////////////////////////////////////////
@implementation CXSmearMenuButtonItem
+ (instancetype)doodleMenuButtonItemWithImageName:(NSString *)imageName imageNormalColor:(UIColor *)normalColor imageSelectColor:(UIColor *)selectColor isSelected:(BOOL)selected
{
    CXSmearMenuButtonItem *item = [[CXSmearMenuButtonItem alloc]init];
    item.imageName = imageName;
    item.normalColor = normalColor;
    item.selectColor = selectColor;
    item.selected = selected;
    return item;
}
@end
