//
//  ViewController.m
//  draw&smear
//
//  Created by 程翔 on 2018/2/27.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "ColorPickerView.h"
#import "MyImageView.h"
#import "CXShineButton.h"

@interface ViewController ()<UIScrollViewDelegate,ColorPickerViewDelegate>

@property (nonatomic,strong) UIButton * shapeButton;    //返回
@property (nonatomic,strong) UIButton * keepButton;     //保存
@property (nonatomic,strong) UIButton * shareButton;    //分享
@property (nonatomic,strong) UIButton * revokeButton;   //撤销

@property (nonatomic,strong) MyImageView * myimageview;

/** 颜色选择view */
@property (nonatomic,strong) ColorPickerView * colorView;

/** 选中的view */
@property (nonatomic,strong) UIView * selectedView;
@property (nonatomic,strong) UIScrollView * scrollView;

/** 颜色 */
@property (nonatomic,strong) UIColor * selectedColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    
    [self setUI];
}

- (void)setNav
{
    //返回
    self.shapeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.shapeButton.frame = CGRectMake(0, 0, 24, 24);
    [self.shapeButton setImage:[UIImage imageNamed:@"Shape"] forState:(UIControlStateNormal)];
    [self.shareButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [self.shareButton addTarget:self action:@selector(shapeButtonBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shapeButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    
    //保存
    self.keepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.keepButton.frame = CGRectMake(0, 0, 24, 24);
    [self.keepButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.keepButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.keepButton addTarget:self action:@selector(keepButtonBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.keepButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //分享
    self.shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.shareButton.frame = CGRectMake(0, 0, 24, 24);
    [self.shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //撤销
    self.revokeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.revokeButton.frame = CGRectMake(0, 0, 24, 24);
    [self.revokeButton setImage:[UIImage imageNamed:@"撤销"] forState:UIControlStateNormal];
    [self.revokeButton addTarget:self action:@selector(revokeButtonBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.revokeButton setTitle:@"撤销" forState:UIControlStateNormal];
    [self.revokeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFixedSpace) target:nil action:nil];
    negativeSpacer.width = 50;
    self.navigationItem.leftBarButtonItems =  @[[[UIBarButtonItem alloc] initWithCustomView:_shapeButton],negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:_keepButton],negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:_shareButton],negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:_revokeButton]];
    
    
    CXShineButton * shineButton = [CXShineButton shineButtonWithTintColor:[UIColor redColor] normalImage:[UIImage imageNamed:@"save_normal"] hightlightImage:[UIImage imageNamed:@"save_select"] normarTypeTapAction:^{
        NSLog(@"<>_<>----嘿嘿嘿");
    } hightlightTypeTapAction:^{
        NSLog(@"<>_<>----哈哈哈");
    }];
    shineButton.isCycleResponse = YES;
    shineButton.frame = CGRectMake(100, 450, 69, 69);
    [self.view addSubview:shineButton];
}

// 返回
- (void)shapeButtonBarButtonAction
{
    
}

//保存到相册
- (void)keepButtonBarButtonAction
{
    UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存到相册" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.myimageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
        
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [ale addAction:sureAction];
    [ale addAction:cancelAction];
    
    [self presentViewController:ale animated:YES completion:nil];
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 分享按钮
- (void)shareButtonBarButtonAction
{
    
}
// 撤销 按钮
- (void)revokeButtonBarButtonAction
{
    
    //    self.myimageview .image = [UIImage imageNamed:@"beast_1"];
    [self.myimageview revokeOption];
    
    
}

- (void)setUI
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, screenW, screenW)];
    [self.view addSubview:_scrollView];
    self.myimageview = [[MyImageView alloc] initWithFrame:_scrollView.bounds];
    [self.scrollView addSubview:self.myimageview];
    
    // 设置内容大小
    _scrollView.contentSize = _myimageview.frame.size;
    // 设置代理为控制器
    _scrollView.delegate = self;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 4;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer:tapGesture];
    
    //设置一个图片的存储路径
    self.myimageview.image = [UIImage imageNamed:@"1.1"];
    CGFloat sc =  (screenW/self.myimageview.image.size.width);
    self.myimageview.frame = CGRectMake(0, 0, screenW, self.myimageview.image.size.height * sc);
    self.myimageview.scaleNum = 1/sc;
    self.myimageview.newcolor = [UIColor redColor];
    
    
    self.colorView = [[ColorPickerView alloc] init];
    _colorView.pickerColorDelegate = self;
    _colorView.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 20 - 150, 150, 150);
    [self.view addSubview:self.colorView];
    self.selectedView = [[UIView alloc] init];
    self.selectedView.frame = CGRectMake(200, [UIScreen mainScreen].bounds.size.height - 100,  100, 20);
    [self.view  addSubview:self.selectedView];
    
    UIButton * changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"切换图片" forState:UIControlStateNormal];
    changeBtn.frame = CGRectMake(200, [UIScreen mainScreen].bounds.size.height - 60, 100, 20);
    [changeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}

//放大缩小
-(void)handleTapGesture:(UIGestureRecognizer*)sender
{
    if(_scrollView.zoomScale > 1.0){
        [_scrollView setZoomScale:1.0 animated:YES];
    }else{
        [_scrollView setZoomScale:4.0 animated:YES];
    }
}

- (void)changeBtnClick {
    [self.myimageview removeFromSuperview];
    [_scrollView setZoomScale:1.0 animated:YES];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.myimageview = [[MyImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenW)];
    [self.scrollView addSubview:self.myimageview];
    int a =   arc4random_uniform(5) + 1;
    NSString *imageName = [NSString stringWithFormat:@"%d.1.png" , a];
    UIImage *image = [UIImage imageNamed:imageName];
    self.myimageview.image = image;
    CGFloat sc =  (screenW/self.myimageview.image.size.width);
    self.myimageview.frame = CGRectMake(0, 0, screenW, self.myimageview.image.size.height * sc);
    self.myimageview.scaleNum = 1/sc;
    if (self.selectedColor == nil) {
        self.selectedColor = [UIColor redColor];
    }
    self.myimageview.newcolor = self.selectedColor;
    self.myimageview.revokePoints = [NSMutableArray array];
}



#pragma mark - ColorPickerViewDelegate
- (void)pickerColor:(UIColor *)color
{
    if (color) {
        self.myimageview.newcolor = color;
        self.selectedColor = color;
        self.selectedView.backgroundColor = color;
    }
}




@end
