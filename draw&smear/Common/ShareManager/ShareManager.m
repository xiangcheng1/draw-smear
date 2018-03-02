//
//  ShareManager.m
//  draw&smear
//
//  Created by 程翔 on 2018/3/2.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "ShareManager.h"
#import <Social/Social.h>

static ShareManager * instance;
@implementation ShareManager


+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ShareManager alloc] init];
    });
    return instance;
}


- (void)shareImage:(UIImage *)image
{
    int index = 0;
    while (image.size.width > 500 || image.size.height > 500) {
        image = [UIImage resizableImageForImage:image];
        if (index > 3) {
            break;
        } else {
            index ++;
        }
    }
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
    [RootViewController presentViewController:activityController animated:YES completion:nil];

    return;
}
@end
