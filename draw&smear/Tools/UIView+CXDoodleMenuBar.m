//
//  UIView+CXDoodleMenuBar.m
//  draw&smear
//
//  Created by 程翔 on 2018/3/1.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "UIView+CXDoodleMenuBar.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,copy) CXDoodleMenuBarSelectItemHandle clickHandle;

@end

@implementation UIView (CXDoodleMenuBar)

-(void)showDoodleMenuBarWithMenuButtonItemArray:(NSArray<CXDoodleMenuButtonItem *> *)menuItemArray clickItemHandle:(CXDoodleMenuBarSelectItemHandle)handle
{
    [self showDoodleMenuBarWithMenuButtonItemArray:menuItemArray tintColor:[UIColor redColor] clickItemHandle:handle];
}

-(void)showDoodleMenuBarWithMenuButtonItemArray:(NSArray<CXDoodleMenuButtonItem *> *)menuItemArray tintColor:(UIColor *)tintColor clickItemHandle:(CXDoodleMenuBarSelectItemHandle)handle
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    CGPoint center = [self.superview convertPoint:self.center fromView:window];
    CXDoodleMenuBar * bar = [CXDoodleMenuBar doodleMenuBarWithMenuButtonItemArray:menuItemArray];
    bar.tintColor = tintColor;
    bar.delegate = self;
    self.clickHandle = handle;
    [bar animationSHowDoodleMenuBarWithAnchorPoint:center];
}

#pragma mark - CXDoodleMenuBarDelegate
- (void)doodleMenuBarClickIndex:(NSInteger)index barItemIsSelectAfter:(BOOL)select
{
    if (self.clickHandle) {
        self.clickHandle(index, select);
    }
}

-(void)setClickHandle:(CXDoodleMenuBarSelectItemHandle)clickHandle
{
    objc_setAssociatedObject(self, @selector(clickHandle), clickHandle, OBJC_ASSOCIATION_COPY);
}

- (CXDoodleMenuBarSelectItemHandle)clickHandle
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
