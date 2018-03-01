//
//  UIView+CXDoodleMenuBar.h
//  draw&smear
//
//  Created by 程翔 on 2018/3/1.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXDoodleMenuBar.h"

typedef void (^CXDoodleMenuBarSelectItemHandle)(NSInteger index, BOOL isTypeSelectAfter);

@interface UIView (CXDoodleMenuBar) <CXDoodleMenuBarDelegate>

/**
 show menu. Detault tintColor 'redColor'
 @param menuItemArray menu item array
 */
- (void)showDoodleMenuBarWithMenuButtonItemArray:(NSArray <CXDoodleMenuButtonItem *> *)menuItemArray
                                 clickItemHandle:(CXDoodleMenuBarSelectItemHandle)handle;

/**
 Show menu. Custom tintColor
 
 @param menuItemArray menu item array
 @param tintColor tintColor
 */
- (void)showDoodleMenuBarWithMenuButtonItemArray:(NSArray<CXDoodleMenuButtonItem *> *)menuItemArray
                                           tintColor:(UIColor *)tintColor
                                     clickItemHandle:(CXDoodleMenuBarSelectItemHandle)handle;
@end
