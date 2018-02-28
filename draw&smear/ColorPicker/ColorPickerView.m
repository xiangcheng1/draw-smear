//
//  ColorPickerView.m
//  draw&smear
//
//  Created by 程翔 on 2018/2/27.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "ColorPickerView.h"

@interface ColorPickerView ()

@property (nonatomic,assign) CGPoint oldPoint;

@end

@implementation ColorPickerView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self creatImageView];
    }
    return self;
}

- (void)creatImageView
{
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"pickerColor.png"];
    [self addSubview:self.imgView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
}

#pragma mark - 点击结束

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    // tap点击的位置
    CGPoint point = [touch locationInView:self.imgView];
    //获取距离上一次取色的距离
    
    CGFloat distance = sqrt(pow(point.x - _oldPoint.x, 2) + pow(point.y - _oldPoint.y, 2));
    if (distance < 5) {
        return;
    }
    
    _oldPoint = point;
    // 1.调用自定义方法，从「点」取颜色
    UIColor *selectedColor = [self colorAtPixel:point];
    
    // 2.高度代理，解析出来的颜色
    if ([self.pickerColorDelegate respondsToSelector:@selector(pickerColor:)] && selectedColor) {
        [self.pickerColorDelegate pickerColor:selectedColor];
    }
}

//通过点获取该点的颜色
- (UIColor *)colorAtPixel:(CGPoint)point
{
    // 判断是否点击在图片上
    if (!CGRectContainsPoint(self.imgView.bounds, point))
    {
        return nil;
    }
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.imgView.image.CGImage;
    NSUInteger width = self.imgView.frame.size.width;
    NSUInteger height = self.imgView.frame.size.height;
    
    // 创建色彩空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytePerPixel = 4;
    int bytesPerRow = bytePerPixel * 1;
    NSInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0,0,0,0};
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    //颜色转换
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    //绘图
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // 获取颜色值
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
