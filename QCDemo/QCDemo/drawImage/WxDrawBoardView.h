//
//  WxDrawBoardView.h
//  QCDemo
//

//

#import <UIKit/UIKit.h>
/**
 *  画板
 */
typedef NS_ENUM(NSInteger,DrawState) {
	DrawNone = 0,
	DrawBegin,
	DrawIsMoving,
	DrawIsEnd
};

typedef void(^TouchPosition)(CGPoint point,DrawState state,UIBezierPath* path,CAShapeLayer* currentLayer);



@interface WxDrawBoardView : UIView

@property(nonatomic,copy)TouchPosition touchPosite;

@end
