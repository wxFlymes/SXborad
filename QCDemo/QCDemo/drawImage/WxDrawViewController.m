//
//  WxDrawViewController.m
//  QCDemo
//

//
#import <QuartzCore/QuartzCore.h>
#import "WxDrawViewController.h"
#import "WxSelectColorBtn.h"
#import "WxDrawBoardView.h"

#define WIDTH 	[UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WxDrawViewController ()

@property(nonatomic,strong)UIColor* penColor;//记录画笔的颜色

@property(nonatomic,strong)WxDrawBoardView* boardView;//画板

@end

@implementation WxDrawViewController

- (void)viewDidLoad {
 	[super viewDidLoad];

	if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}

	[self setupColorSettingView];
	[self setupBoard];//添加画板view，用来处理绘画时间
}

//添加画笔颜色选择部分
-(void)setupColorSettingView
{
	NSArray* colorArr = [NSArray arrayWithObjects:[UIColor redColor], [UIColor purpleColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor], nil];
	for (int i = 0; i < 5; i++) {
		WxSelectColorBtn* btn = [[WxSelectColorBtn alloc] initWithColor:(UIColor*)(colorArr[i])];
		btn.frame = CGRectMake(15+i*50, 20, 40, 40);
		[btn addTarget:self action:@selector(settingPenColorEvent:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:btn];
	}

}
//设置颜色按钮点击事件
-(void)settingPenColorEvent:(WxSelectColorBtn*)sender
{
	self.penColor = sender.backgroundColor;
}

//添加画板
/**
 *  在CAShapeLayer的上面添加一层view，由于layer无法响应事件，通过view来响应触摸事件
 */
-(void)setupBoard
{
	self.boardView = [[WxDrawBoardView alloc] initWithFrame:CGRectMake(0, 70, WIDTH, HEIGHT-134)];
	self.boardView.backgroundColor = [UIColor clearColor];
	 __weak typeof(self) weakSelf = self;
	self.boardView.touchPosite = ^(CGPoint point,DrawState state,UIBezierPath* path,CAShapeLayer* currentLayer)
	{
		[weakSelf beizerPathWithPath: path Position:point State:state Layer:currentLayer];
	};
	[self.view addSubview:self.boardView];

}

/**
 *  确定贝塞尔曲线
 *
 *  @param point 坐标点
 *  @param state 状态
 */
-(void)beizerPathWithPath: (UIBezierPath*)path Position:(CGPoint)point State:(DrawState)state Layer:(CAShapeLayer*)currentLayer
{

	NSLog(@"{x=%.1f,y=%.1f}",point.x,point.y);
	if (state == DrawBegin) {
		[self.view.layer addSublayer:currentLayer];
		[path moveToPoint:point];
	}
	else if (state == DrawIsMoving)
	{
		[path addLineToPoint:point];
	}

	currentLayer.path = path.CGPath;
	[self drawingEvent:currentLayer];
}

-(void)drawingEvent:(CAShapeLayer*)layer
{

	layer.lineWidth = 10.0f; // 线条宽度
	layer.fillColor = [UIColor clearColor].CGColor;//填充颜色
	layer.strokeColor = self.penColor.CGColor; // 边缘线条的颜色
	//drawLayer.miterLimit = 2.;
	//drawLayer.lineDashPhase = 10;// 未知？
	//drawLayer.lineDashPattern = @[@3,@10];// 虚线

	//drawLayer.fillColor = [UIColor greenColor].CGColor; // 闭环填充的颜色

	//drawLayer.fillRule = kCAFillRuleNonZero;
	/*
	 CA_EXTERN NSString *const kCAFillRuleNonZero
	 CA_EXTERN NSString *const kCAFillRuleEvenOdd
	 */

	//drawLayer.lineCap = kCALineCapSquare; // 边缘线的类型
	/*
	 CA_EXTERN NSString *const kCALineCapButt
	 CA_EXTERN NSString *const kCALineCapRound
	 CA_EXTERN NSString *const kCALineCapSquare
	 */

//	drawLayer.lineJoin = kCALineJoinRound;
}

@end
