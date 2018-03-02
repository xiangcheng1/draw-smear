//
//  CXRecommendColorView.m
//  draw&smear
//
//  Created by 程翔 on 2018/3/2.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "CXRecommendColorView.h"

@interface CXRecommendColorView ()

@property (nonatomic,strong) NSMutableArray * itemArray;
@property (nonatomic,assign) NSInteger selectIndex;

@end

@implementation CXRecommendColorView
#pragma mark -life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[CXRecommendColorModel recommendColorModelArray] enumerateObjectsUsingBlock:^(CXRecommendColorModel * colorModel, NSUInteger idx, BOOL * _Nonnull stop) {
            CXRecommendColorItemView * itemView = [[CXRecommendColorItemView alloc] init];
            itemView.backgroundColor = [UIColor colorWithHexString:colorModel.hexColorString];
            if (colorModel.isSelectColor) {
                itemView.tagView.hidden = NO;
                self.selectIndex = idx;
            }
            itemView.tag = idx;
            [self addSubview:itemView];
            [self.itemArray addObject:itemView];
            UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItemAction:)];
            [itemView addGestureRecognizer:tapGes];
        }];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width / self.itemArray.count;
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = idx * width;
        [obj setFrame:CGRectMake(x, 0, width, self.height)];
    }];
    
     [self.recommendColorSelectSubject sendNext:self.selectItemView];
}

#pragma mark - public methods
- (void)updaeRecommendColors
{
    NSArray * colorModelArray = [CXRecommendColorModel recommendColorModelArray];
    [colorModelArray enumerateObjectsUsingBlock:^(CXRecommendColorModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isSelectColor) {
            if (idx == self.selectIndex) {
                 model.hexColorString = [self.selectItemView.backgroundColor HEXString];
            } else {
                model.isSelectColor = NO;
            }
        } else {
            if (idx == self.selectIndex) {
                model.isSelectColor = YES;
                model.hexColorString = [self.selectItemView.backgroundColor HEXString];
            }
        }
    }];
}


- (void)selectItemAction:(UITapGestureRecognizer *)tap
{
    [self.itemArray enumerateObjectsUsingBlock:^(CXRecommendColorItemView * recommendColorItemView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == [tap view].tag) {
            self.selectIndex = idx;
            recommendColorItemView.tagView.hidden = NO;
            [self.recommendColorSelectSubject sendNext:[tap view]];
        } else {
            recommendColorItemView.tagView.hidden = YES;
        }
    }];
}

#pragma mark - getters
-(CXRecommendColorItemView *)selectItemView
{
    return self.itemArray[self.selectIndex];
}

-(NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

-(RACSubject *)recommendColorSelectSubject
{
    if (_recommendColorSelectSubject == nil) {
        _recommendColorSelectSubject = [RACSubject subject];
    }
    return _recommendColorSelectSubject;
}

@end

////////////////////////////////////////////////////////
static CGFloat const KtagSquraWH = 10;
static CGFloat const KtagPadding = 3;
@implementation CXRecommendColorItemView

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:self.tagView];
    self.tagView.frame = CGRectMake(self.width - KtagPadding - KtagSquraWH, KtagPadding, KtagSquraWH, KtagSquraWH);
    //mask
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(KtagSquraWH, 0)];
    [path addLineToPoint:CGPointMake(KtagSquraWH, KtagSquraWH)];
    [path closePath];
    layer.path = path.CGPath;
    self.tagView.layer.mask = layer;
}

-(UIView *)tagView
{
    if (_tagView == nil) {
        _tagView = [[UIView alloc] init];
        _tagView.backgroundColor = [UIColor blackColor];
        _tagView.hidden = YES;
    }
    return _tagView;
}

@end

///////////////////////////////////////////////////////////////

@implementation CXRecommendColorModel

+(NSArray<CXRecommendColorModel *> *)recommendColorModelArray
{
    //从本地读取，没有的话，设置默认的颜色数组，并返回
    NSArray *hexColorArray = @[@"#FFCF1B",@"#3A9885",@"#248EE0",@"#424242",@"#D93E45"];
    NSMutableArray * recommendColorModelArray = [NSMutableArray array];
    [hexColorArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CXRecommendColorModel * model = [[CXRecommendColorModel alloc] init];
        model.hexColorString = obj;
        model.isSelectColor = NO;
        if (idx == 0) {
            model.isSelectColor = YES;
        }
        [recommendColorModelArray addObject:model];
    }];
    return recommendColorModelArray;
}


@end
