//
//  WxSelectColorBtn.h
//  QCDemo
//

//

#import <UIKit/UIKit.h>
/**
 *  设置画笔颜色
 */

@protocol SelectColorDelegate <NSObject>

-(void)setPenColor:(UIColor*)color;

@end

@interface WxSelectColorBtn : UIButton
-(instancetype)initWithColor:(UIColor*)color;

@end
