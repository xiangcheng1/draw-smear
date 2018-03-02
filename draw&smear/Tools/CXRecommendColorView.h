//
//  CXRecommendColorView.h
//  draw&smear
//
//  Created by 程翔 on 2018/3/2.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXRecommendColorItemView;
@interface CXRecommendColorView : UIView

@property (nonatomic,strong) RACSubject * recommendColorSelectSubject;
@property (nonatomic,strong) CXRecommendColorItemView * selectItemView;
@end

@interface CXRecommendColorItemView : UIView

@property (nonatomic,strong) UIView * tagView;

@end


@interface CXRecommendColorModel : NSObject

/**
  is current selected color,default is 'NO'.
 */
@property (nonatomic,assign) BOOL isSelectColor;

/**
 hexadecimal color
 */
@property (nonatomic,strong) NSString * hexColorString;

/**
 get default color array.
 */
+ (NSArray <CXRecommendColorModel *>*)recommendColorModelArray;

@end
