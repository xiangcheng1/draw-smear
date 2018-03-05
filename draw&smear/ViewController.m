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
#import "CXSmearMenuBar.h"
#import "CXRecommendColorView.h"

@interface ViewController ()<UIScrollViewDelegate,ColorPickerViewDelegate,CXSmearMenuBarDelegate>

@property (nonatomic,strong) UIButton * shapeButton;    //返回
@property (nonatomic,strong) UIButton * keepButton;     //保存
@property (nonatomic,strong) UIButton * shareButton;    //分享
@property (nonatomic,strong) UIButton * revokeButton;   //撤销

@property (nonatomic,strong) MyImageView * myimageview;

/** 颜色选择view */
@property (nonatomic,strong) ColorPickerView * colorView;

/** 选中的view */
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) CXRecommendColorView * recommendColorView;

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
    self.navigationItem.title = @"我涂我画";
    
    CXSmearMenuBar * smearMenuBar = [CXSmearMenuBar smearMenuBarWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60) buttonItemArray:[self p_getSmearMenuButtonItemArray]];
    smearMenuBar.delegate = self;
    smearMenuBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self.view addSubview:smearMenuBar];
}

- (NSArray *)p_getSmearMenuButtonItemArray
{
    NSArray * imageNameArray = @[@"share_normal",@"cancel_normal",@"save_normal",@"empty_normal",@"next_normal"];
    NSMutableArray * itemArray = [NSMutableArray array];
    [imageNameArray enumerateObjectsUsingBlock:^(NSString * imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        CXSmearMenuButtonItem * item = [CXSmearMenuButtonItem smearMenuButtonItemWithImageName:imageName imageNormalColor:[UIColor redColor] imageSelectColor:[UIColor blueColor] isSelected:NO];
        [itemArray addObject:item];
    }];
    return itemArray;
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


- (void)setUI
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, screenW, screenW)];
    _scrollView.backgroundColor = [UIColor colorWithWholeRed:230 green:230 blue:230];
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
    self.myimageview.baseImage = [UIImage imageNamed:@"1.1"];
    CGFloat sc =  (screenW/self.myimageview.image.size.width);
    self.myimageview.frame = CGRectMake(0, 0, screenW, self.myimageview.image.size.height * sc);
    self.myimageview.scaleNum = 1/sc;
    self.myimageview.newcolor = [UIColor redColor];
    
    
    self.colorView = [[ColorPickerView alloc] init];
    _colorView.pickerColorDelegate = self;
    _colorView.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 180, 100, 100);
    [self.view addSubview:self.colorView];
    
    self.recommendColorView = [[CXRecommendColorView alloc] initWithFrame:CGRectMake(self.colorView.maxX + 20, self.colorView.midY, screenW - self.colorView.maxX - 40, 30)];
    [self.recommendColorView.recommendColorSelectSubject subscribeNext:^(CXRecommendColorItemView * recommendItemView) {
        self.selectedColor = recommendItemView.backgroundColor;
        self.myimageview.newcolor = recommendItemView.backgroundColor;
    }];
    [self.view addSubview:self.recommendColorView];
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
    self.myimageview.baseImage = image;
    CGFloat sc =  (screenW/self.myimageview.image.size.width);
    self.myimageview.frame = CGRectMake(0, 0, screenW, self.myimageview.image.size.height * sc);
    self.myimageview.scaleNum = 1/sc;
    if (self.selectedColor == nil) {
        self.selectedColor = [UIColor redColor];
    }
    self.myimageview.newcolor = self.selectedColor;
    self.myimageview.revokePoints = [NSMutableArray array];
}


#pragma mark - CXSmearMenuBar
- (void)smearMenuBarClickIndex:(NSInteger)index barItemIsSelectAfter:(BOOL)select
{
    if (index == 0) { // 颜色
        [self shareImage];
    } else if (index == 1) {    //撤销
        [self.myimageview revokeOption];
    } else if (index == 2) {    //保存
        [self keepButtonBarButtonAction];
    } else if (index == 3) {    //清空
        [self.myimageview emptyOption];
    } else if (index == 4) {    //下一个
        [self changeBtnClick];
    }
}

- (void)shareImage
{
//    UIGraphicsBeginImageContextWithOptions(self.myimageview.size, NO, 0.0);
//    [self.myimageview.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [[ShareManager shareInstance] shareImage:self.myimageview.image];
}


#pragma mark - ColorPickerViewDelegate
- (void)pickerColor:(UIColor *)color
{
    if (color) {
        self.myimageview.newcolor = color;
        self.selectedColor = color;
        [self.recommendColorView selectItemView].backgroundColor = color;
    }
}




@end
