//
//  ViewController.m
//  EmitterEffect
//
//  Created by AlbertYuan on 2021/3/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self  configSnowEmitterLayer];
}

- (void)configSnowEmitterLayer {

    // 生成一个CAEmitterLayer
   CAEmitterLayer *snowEmitterLayer = [CAEmitterLayer layer];

    snowEmitterLayer.birthRate = 1.0;

   // 生成粒子的位置
   snowEmitterLayer.emitterPosition = CGPointMake(0, 0);

    // 生成粒子的区域大小
   snowEmitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width* 2, 1);

   // 设置粒子发射模式
   snowEmitterLayer.emitterMode = kCAEmitterLayerSurface;
   // 设置粒子源的形状
   snowEmitterLayer.emitterShape = kCAEmitterLayerLine;


   // 设置layer的透明度，圆角等
   snowEmitterLayer.shadowOpacity = 1.0;
   snowEmitterLayer.shadowRadius = 0.0;
   snowEmitterLayer.shadowOffset = CGSizeMake(0.0, 1.0f);
   snowEmitterLayer.shadowColor = [[UIColor whiteColor] CGColor];


   // 设置发射出的粒子单元
    //存放粒子种类的数组
    NSMutableArray *snow_array = @[].mutableCopy;
    for (NSInteger i=1; i<5; i++) {
        [snow_array addObject:[self createSnowCell]];
    }

   snowEmitterLayer.emitterCells = [NSArray arrayWithArray:snow_array];
    // 添加到layer
   [self.view.layer addSublayer:snowEmitterLayer];

}


- (CAEmitterCell *)createSnowCell {

    // 创建粒子单元
   CAEmitterCell *snowCell = [CAEmitterCell emitterCell];

   snowCell.birthRate = 50.0f;// 每秒生成例子频率
   snowCell.lifetime = 120.f; // 粒子系统的生命周期

   snowCell.velocity = -50;   // 粒子速度
   snowCell.velocityRange = 20; // 粒子速度范围
   snowCell.yAcceleration = 2; // 粒子y方向的加速度分量
   snowCell.emissionRange = 0.5 * M_PI; // 周围发射角度
   snowCell.spinRange = 0.25 * M_PI;  // 旋转角度
   snowCell.contents = (id)[[UIImage imageNamed:@"snow"] CGImage]; // 粒子显示内容
   snowCell.color = [[UIColor whiteColor] CGColor]; // 粒子颜色
    snowCell.redRange = 0.0;
    snowCell.blueRange = 0.1;
    snowCell.greenRange = 0.0;
    snowCell.scale = 0.05;
    snowCell.scaleRange = 0.1;

    snowCell.alphaRange = 1.0;
    snowCell.alphaSpeed = 2.0f;

   return snowCell;
}

@end


/*
 1、CAEmitterCell

 CAEmitterCell ＊effectCell = [CAEmitterCell emitterCell];

 effectCell 几个重要属性：

 1）.birthRate 顾名思义没有这个也就没有effectCell，这个必须要设置，具体含义是每秒某个点产生的effectCell数量

 2）.lifetime & lifetimeRange 表示effectCell的生命周期，既在屏幕上的显示时间要多长。

 3）.contents 这个和CALayer一样，只是用来设置图片

 4）.name 这个是当effectCell存在caeEmitter 的emitterCells中用来辨认的。用到setValue forKeyPath比较有用

 5）.velocity & velocityRange & emissionRange 表示cell向屏幕右边飞行的速度 & 在右边什么范围内飞行& ＋－角度扩散

 6）.把cell做成array放进caeEmitter.emitterCells里去。caeEmitter.renderMode有个效果很不错，能变成火的就是kCAEmitterLayerAdditive

 属性：

 alphaRange:  一个粒子的颜色alpha能改变的范围；

 alphaSpeed:粒子透明度在生命周期内的改变速度；

 birthrate：粒子参数的速度乘数因子；

 blueRange：一个粒子的颜色blue 能改变的范围；

 blueSpeed: 粒子blue在生命周期内的改变速度；

 color:粒子的颜色

 contents：是个CGImageRef的对象,既粒子要展现的图片；

 contentsRect：应该画在contents里的子rectangle：

 emissionLatitude：发射的z轴方向的角度

 emissionLongitude:x-y平面的发射方向

 emissionRange；周围发射角度

 emitterCells：粒子发射的粒子

 enabled：粒子是否被渲染

 greenrange: 一个粒子的颜色green 能改变的范围；

 greenSpeed: 粒子green在生命周期内的改变速度；

 lifetime：生命周期

 lifetimeRange：生命周期范围

 magnificationFilter：不是很清楚好像增加自己的大小

 minificatonFilter：减小自己的大小

 minificationFilterBias：减小大小的因子

 name：粒子的名字

 redRange：一个粒子的颜色red 能改变的范围；

 redSpeed; 粒子red在生命周期内的改变速度；

 scale：缩放比例：

 scaleRange：缩放比例范围；

 scaleSpeed：缩放比例速度：

 spin：子旋转角度

 spinrange：子旋转角度范围

 style：不是很清楚：

 velocity：速度

 velocityRange：速度范围

 xAcceleration:粒子x方向的加速度分量

 yAcceleration:粒子y方向的加速度分量

 zAcceleration:粒子z方向的加速度分量

 2、CAEmitterLayer
 CAEmitterLayer提供了一个基于Core Animation的粒子发射系统，粒子用CAEmitterCell来初始化。粒子画在背景层盒边界上

 属性:

 birthRate:粒子产生系数，默认1.0；

 emitterCells: 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上；

 emitterDepth:决定粒子形状的深度联系：emittershape

 emitterMode:发射模式

 NSString * const kCAEmitterLayerPoints;

 NSString * const kCAEmitterLayerOutline;

 NSString * const kCAEmitterLayerSurface;

 NSString * const kCAEmitterLayerVolume;

 emitterPosition:发射位置

 emitterShape:发射源的形状：

 NSString * const kCAEmitterLayerPoint;

 NSString * const kCAEmitterLayerLine;

 NSString * const kCAEmitterLayerRectangle;

 NSString * const kCAEmitterLayerCuboid;

 NSString * const kCAEmitterLayerCircle;

 NSString * const kCAEmitterLayerSphere;

 emitterSize:发射源的尺寸大；

 emitterZposition:发射源的z坐标位置；

 lifetime:粒子生命周期

 preservesDepth:不是多很清楚（粒子是平展在层上）

 renderMode:渲染模式：

 NSString * const kCAEmitterLayerUnordered;

 NSString * const kCAEmitterLayerOldestFirst;

 NSString * const kCAEmitterLayerOldestLast;

 NSString * const kCAEmitterLayerBackToFront;

 NSString * const kCAEmitterLayerAdditive;

 scale:粒子的缩放比例：

 seed：用于初始化随机数产生的种子

 spin:自旋转速度

 velocity：粒子速度
 */
