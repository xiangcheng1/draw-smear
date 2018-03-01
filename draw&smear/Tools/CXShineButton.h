//
//  CXShineButton.h
//  draw&smear
//
//  Created by 程翔 on 2018/3/1.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cxActionBlock)(void);

@interface CXShineButton : UIView

/**
 default 'NO'. if 'YES' click the button animate everytime , else  animate once time if you want animate one more time you need call '- (void)clearhightlight;' method first.
 */
@property (nonatomic,assign) BOOL isNeedAnimateEverytime;

/**
 default 'YES' means need deal click actions
 */
@property (nonatomic,assign) BOOL isNeedDealingActions;

/**
 default 'NO' , While 'NO' if hightlight click btn it will not become normal, if 'YES' it will.
 */
@property (nonatomic,assign) BOOL isCycleResponse;

/**
 unconventional to change button image
 */
@property (nonatomic,strong) UIImage * unconventionalImage;

/**
 instance method
 
 @param tintColor tint color
 @param normalImage normal image
 @param hightlightImage hightlight image
 @param normalAction normal showing tap button action
 @param hightlightAction hightlight showing tap button aciton
 @return instance
 */
+(instancetype)shineButtonWithTintColor:(UIColor *)tintColor
                            normalImage:(UIImage *)normalImage
                        hightlightImage:(UIImage *)hightlightImage
                    normarTypeTapAction:(cxActionBlock)normalAction
                hightlightTypeTapAction:(cxActionBlock)hightlightAction;

/** clear hightlight status */
- (void)clearhightlight;

/** animation to hightlight */
- (void)animatehightlight;

/** no animation to hightlight */
- (void)noAnimationhightlight;

/**
 If you want change the image or tint color. such  as change color theme . It will not change the current showing image
 
 @param normalImage normal image
 @param hightlightImage hightlight image
 @param tintColor tint color
 */
- (void)reloadStateWithNormalImage:(UIImage *)normalImage
                   hightlightImage:(UIImage *)hightlightImage
                         tintColor:(UIColor *)tintColor;
/**
 Change the image or tint color. such as change color theme. It will change the current showing image
 
 @param normalImage normal type image
 @param hightlightImage hightlight type image
 @param showingImage current showing image
 @param tintColor tint color
 */
- (void)reloadStateWithNormalImage:(UIImage *)normalImage
                   hightlightImage:(UIImage *)hightlightImage
                      showingImage:(UIImage *)showingImage
                         tintColor:(UIColor *)tintColor;
@end

//////////////////////////////////////////////////////////////////////// pravite
@interface CXAnimateLineContainerView : UIView
/** line color */
@property (nonatomic,strong) UIColor * lineColor;
/** animate */
- (void)lineAnimate;
@end
