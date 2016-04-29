//
//  WxSelectColorBtn.m
//  QCDemo
//
.
//

#import "WxSelectColorBtn.h"

@implementation WxSelectColorBtn

-(instancetype)initWithColor:(UIColor*)color
{
	if (self = [super init]) {
		self.bounds = CGRectMake(0, 0, 40, 40);
		self.backgroundColor = color;
	}
	return self;
}

@end
