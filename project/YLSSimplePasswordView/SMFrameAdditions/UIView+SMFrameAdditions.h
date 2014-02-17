#import <UIKit/UIKit.h>

@interface UIView (SMFrameAdditions)

@property (nonatomic, assign) CGPoint $origin;
@property (nonatomic, assign) CGSize $size;
@property (nonatomic, assign) CGFloat $x, $y, $width, $height;
@property (nonatomic, assign) CGFloat $left, $top, $right, $bottom;

@end
