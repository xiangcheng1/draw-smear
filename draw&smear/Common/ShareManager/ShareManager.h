//
//  ShareManager.h
//  draw&smear
//
//  Created by 程翔 on 2018/3/2.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareManager : NSObject

+ (instancetype)shareInstance;

- (void)shareImage:(UIImage *)image;

@end
