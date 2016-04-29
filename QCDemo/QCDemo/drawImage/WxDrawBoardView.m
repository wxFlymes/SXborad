//
//  WxDrawBoardView.m
//  QCDemo
//

//

#import "WxDrawBoardView.h"

#define WIDTH 	[UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WxDrawBoardView ()
{
	UIBezierPath* path;
	CAShapeLayer* currentLayer;
}

@end

@implementation WxDrawBoardView
/*
 每一次的绘制都会重新生成一个贝塞尔对象
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	path = [UIBezierPath bezierPath];
	currentLayer = [CAShapeLayer layer];
	currentLayer.backgroundColor = [UIColor clearColor].CGColor;
	currentLayer.frame = CGRectMake(0, 70, WIDTH, HEIGHT - 134);
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	self.touchPosite(point,DrawBegin,path,currentLayer);
	//NSLog(@"开始绘图");
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	CGMutablePathRef pathRef = CGPathCreateMutable();
	CGPathMoveToPoint(pathRef, NULL, 0, 0);
	CGPathAddLineToPoint(pathRef, NULL, 0, HEIGHT-134);
	CGPathAddLineToPoint(pathRef, NULL, WIDTH, HEIGHT-134);
	CGPathAddLineToPoint(pathRef, NULL, WIDTH, 0);
	CGPathCloseSubpath(pathRef);
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	if (CGPathContainsPoint(pathRef, NULL, point, NO)) {
		self.touchPosite(point,DrawIsMoving,path,currentLayer);
	}
	//NSLog(@"正在绘图");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	self.touchPosite(point,DrawIsEnd,path,currentLayer);
	//NSLog(@"结束绘图");
}



@end
