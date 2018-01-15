//
//  ViewController.m
//  Shuff
//
//  Created by mc on 2018/1/2.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

#define Frame(x,y,w,h)   CGRectMake(x, y, w, h)


@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scroll;
    
    NSArray *imageAry;//所有的图片
    
    NSArray *selectImageAry;//选中的三张图片源
    
    NSInteger index;//当前选中
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addScrlloView];
}


-(void)addScrlloView
{
    
    //图片源
    imageAry=@[@"http://img.taopic.com/uploads/allimg/120727/201995-120HG1030762.jpg",@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg",@"http://img.zcool.cn/community/01711b59426ca1a8012193a31e5398.gif",@"http://www.taopic.com/uploads/allimg/140421/318743-140421213T910.jpg",@"http://101.37.126.235:8080//upload/shop_advert/1515140598780.jpg"];//网上找的图片地址
    scroll =[[UIScrollView alloc]initWithFrame:Frame(0, 114, WIDTH, HEIGHT -114)];
    scroll.backgroundColor=[UIColor redColor];
    scroll.contentSize =CGSizeMake(WIDTH*3, 0);
    scroll.delegate =self;
    scroll.pagingEnabled =YES;
    [self.view addSubview:scroll];
    scroll.contentOffset =CGPointMake(WIDTH, 0);
    
    for (int i=0; i<3; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:Frame(i*WIDTH, 0, WIDTH, HEIGHT -114)];
        imageView.tag=i+1;
        imageView.backgroundColor=[UIColor greenColor];
        
        [scroll addSubview:imageView];
    }
    [self loadImage];
}


#pragma mark - 加载图片
- (void)loadImage
{
    //index默认为0也就是第一次加载的时候
    
    if (index==0) {//当前选中数据源第一张图片

        selectImageAry=@[imageAry[imageAry.count-1],imageAry[index],imageAry[index+1]];
    }else if (index==imageAry.count-1){//当前选中数据源最后一张图片
        selectImageAry=@[imageAry[index-1],imageAry[index],imageAry[0]];
    }else{//正常情况
        selectImageAry=@[imageAry[index-1],imageAry[index],imageAry[index+1]];
    }

    
    for (int i = 0; i<3; i++) {
        UIImageView *imageView=[scroll viewWithTag:i+1];
        [imageView sd_setImageWithURL:[NSURL URLWithString:selectImageAry[i]]];
    }
    
    scroll.contentOffset =CGPointMake(WIDTH, 0);//加载图片后再回到中间
    
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    if (aScrollView ==scroll) {
        int x = aScrollView.contentOffset.x;
        //往下翻一张
        if(x >= (2*scroll.frame.size.width)) {
            if (index==imageAry.count-1) {
                index=0;
            }else{
                index+=1;
            }
            [self loadImage];
            
        }
        //往上翻
        if(x <= 0) {
            if (index==0) {
                index=imageAry.count-1;
            }else{
                index-=1;
            }
            
            [self loadImage];
        }
    }
    //    scroll.contentOffset =CGPointMake(WIDTH, 0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
