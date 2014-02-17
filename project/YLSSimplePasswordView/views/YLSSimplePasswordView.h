#define POINTS_VIEW_TAG 2323

#import "UIView+SMFrameAdditions.h"

@protocol YLSPasswordButtonDelegate

-(void) pressed:(NSString*)value;

@end

// internal use for YLSSimplePasswordView, normally you will not use this class directly
@interface YLSPasswordButton : UIButton

-(id) initWithTitle:(NSString*)title Value:(NSString*)value Color:(UIColor*)color Origin:(CGPoint)origin Delegate:(id<YLSPasswordButtonDelegate>)delegate;

@end

@protocol YLSSimplePasswordViewDelegate

@required

// judge wether the password correct or net
-(BOOL) passwordCorrect:(NSString*)input;

// what to do when user input the correct password
-(void) inputDone;

@end

@interface YLSSimplePasswordView : UIView<YLSPasswordButtonDelegate>

-(id) initWithDelegate:(id<YLSSimplePasswordViewDelegate>)delegate;

@end



