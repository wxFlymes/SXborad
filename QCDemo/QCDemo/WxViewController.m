//
//  ViewController.m
//  QCDemo
//


#import "WxViewController.h"
#import "DRview.h"

@interface WxViewController ()
{
	UIButton* niceBtn;
	UIView* gView;
}

@end

@implementation WxViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"quartzCore示例";

	if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}


	niceBtn = [self addCustomBtn:@"赞我"];
	//niceBtn.hidden = YES;
	[niceBtn addTarget:self action:@selector(displayCustomView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:niceBtn];



}
-(void)displayCustomView:(UIButton*)sender
{
	gView = [self addCusstomView];
	[self.view addSubview:gView];
}

-(UIView*)addCusstomView
{

	UIView* view = [[DRview alloc] initWithFrame:CGRectMake(0,50 , 375, 400)];
	view.backgroundColor = [UIColor lightGrayColor];
	return view;
}

-(void)goodmeClick:(UIButton*)sender
{
	CABasicAnimation* moveAnimamtion = [CABasicAnimation animationWithKeyPath:@"position"];
	moveAnimamtion.fromValue = [NSValue valueWithCGPoint:CGPointMake(40, 20)];
	moveAnimamtion.toValue = [NSValue valueWithCGPoint:CGPointMake(375/2.0, 667/2.0)];

	//做动画的时候，如果设置fillmode，必须同时设置removedOnCompletion为NO，否则fillmode失效
	//moveAnimamtion.removedOnCompletion = NO;

	CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
	scaleAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
	scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 80, 40)];

	CAAnimationGroup* group = [CAAnimationGroup animation];
	group.animations = [NSArray arrayWithObjects:moveAnimamtion, scaleAnimation,nil];
	group.delegate  = self;
	group.duration = 1.5;
	group.fillMode = kCAFillModeForwards;
	//group.removedOnCompletion = NO;
	[sender.layer addAnimation:group forKey:nil];


}
//-(void)animationDidStart:(CAAnimation *)anim
//{
//	niceBtn.hidden = NO;
//}

-(UIButton*)addCustomBtn:(NSString*)title
{

	UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = CGRectMake(0, 0, 80, 40);
	btn.backgroundColor = [UIColor lightGrayColor];
	[btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
	[btn setTitle:title forState:UIControlStateNormal];
	return btn;
}



@end
