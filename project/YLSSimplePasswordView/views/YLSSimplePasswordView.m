#import "YLSSimplePasswordView.h"

#pragma mark - YLSSimplePasswordView

@implementation YLSSimplePasswordView

{
    id<YLSSimplePasswordViewDelegate> myDelegate;
    NSMutableArray *inputArray;
    NSArray *pointArray;
    UIColor *pointColor;
}

-(id) initWithDelegate:(id<YLSSimplePasswordViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        myDelegate = delegate;
        pointColor = [UIColor colorWithRed:147/255.0f green:204/255.0f blue:242/255.0f alpha:1.0f];// fixed color, you can change it when needed
        inputArray = [NSMutableArray arrayWithCapacity:4];
        
        // "input password" label
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(220, 40, 100, 40);
        label.text = @"input code";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20.0];
        label.textColor = [UIColor whiteColor];
        
        // input indicator
        UIView *pointViews = [[UIView alloc] init];
        pointViews.frame = CGRectMake(193, 90, 154, 16);
        pointViews.tag = POINTS_VIEW_TAG;
        
        UIButton *point1 = [self makePasswordPointWithOrigin:CGPointMake(0, 0)];
        UIButton *point2 = [self makePasswordPointWithOrigin:CGPointMake(46, 0)];
        UIButton *point3 = [self makePasswordPointWithOrigin:CGPointMake(92, 0)];
        UIButton *point4 = [self makePasswordPointWithOrigin:CGPointMake(138, 0)];
        
        [pointViews addSubview:point1];
        [pointViews addSubview:point2];
        [pointViews addSubview:point3];
        [pointViews addSubview:point4];
        
        pointArray = [NSArray arrayWithObjects:point1, point2, point3, point4, nil];
        
        // number buttons
        YLSPasswordButton *button1 = [[YLSPasswordButton alloc] initWithTitle:@"1" Value:@"1" Color:pointColor Origin:CGPointMake(120, 180) Delegate:self];
        YLSPasswordButton *button2 = [[YLSPasswordButton alloc] initWithTitle:@"2" Value:@"2" Color:pointColor Origin:CGPointMake(230, 180) Delegate:self];
        YLSPasswordButton *button3 = [[YLSPasswordButton alloc] initWithTitle:@"3" Value:@"3" Color:pointColor Origin:CGPointMake(340, 180) Delegate:self];
        YLSPasswordButton *button4 = [[YLSPasswordButton alloc] initWithTitle:@"4" Value:@"4" Color:pointColor Origin:CGPointMake(120, 290) Delegate:self];
        YLSPasswordButton *button5 = [[YLSPasswordButton alloc] initWithTitle:@"5" Value:@"5" Color:pointColor Origin:CGPointMake(230, 290) Delegate:self];
        YLSPasswordButton *button6 = [[YLSPasswordButton alloc] initWithTitle:@"6" Value:@"6" Color:pointColor Origin:CGPointMake(340, 290) Delegate:self];
        YLSPasswordButton *button7 = [[YLSPasswordButton alloc] initWithTitle:@"7" Value:@"7" Color:pointColor Origin:CGPointMake(120, 400) Delegate:self];
        YLSPasswordButton *button8 = [[YLSPasswordButton alloc] initWithTitle:@"8" Value:@"8" Color:pointColor Origin:CGPointMake(230, 400) Delegate:self];
        YLSPasswordButton *button9 = [[YLSPasswordButton alloc] initWithTitle:@"9" Value:@"9" Color:pointColor Origin:CGPointMake(340, 400) Delegate:self];
        YLSPasswordButton *button0 = [[YLSPasswordButton alloc] initWithTitle:@"0" Value:@"0" Color:pointColor Origin:CGPointMake(230, 510) Delegate:self];
        YLSPasswordButton *buttonDel = [[YLSPasswordButton alloc] initWithTitle:@"\u2190" Value:@"del" Color:pointColor Origin:CGPointMake(340, 510) Delegate:self];
        
        [self addSubview:label];
        [self addSubview:pointViews];
        [self addSubview:button1];
        [self addSubview:button2];
        [self addSubview:button3];
        [self addSubview:button4];
        [self addSubview:button5];
        [self addSubview:button6];
        [self addSubview:button7];
        [self addSubview:button8];
        [self addSubview:button9];
        [self addSubview:button0];
        [self addSubview:buttonDel];
    }
    return self;
}

#pragma mark - YLSPasswordButtonDelegate method

-(void) pressed:(NSString*)value
{
    // when "del" tapped
    if([@"del" isEqualToString:value]){
        if([inputArray count] > 0){
            [inputArray removeLastObject];
            [[pointArray objectAtIndex:[inputArray count]] setBackgroundColor:[UIColor clearColor]];// reset previous indicator color
        }
        return;
    }
    
    if([inputArray count] < 4){
        [inputArray addObject:value];
        [[pointArray objectAtIndex:([inputArray count] - 1)] setBackgroundColor:pointColor];// refresh current indicator color
    }
    
    if([inputArray count] == 4){
        NSString* completePassword = [NSString stringWithFormat:@"%@%@%@%@", [inputArray objectAtIndex:0], [inputArray objectAtIndex:1], [inputArray objectAtIndex:2], [inputArray objectAtIndex:3]];
        [self checkPassword:completePassword];
    }
}

#pragma mark - private method

-(UIButton*) makePasswordPointWithOrigin:(CGPoint)origin
{
    UIButton *point = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    point.$width = 16.0;
    point.$height = 16.0;
    point.$x = origin.x;
    point.$y = origin.y;
    [point.layer setCornerRadius:8.0];
    [point.layer setBorderWidth:1.0];
    [point.layer setBorderColor:pointColor.CGColor];
    [point setBackgroundColor:[UIColor clearColor]];
    return point;
}

-(void) checkPassword:(NSString*)password
{
    BOOL flag = [myDelegate passwordCorrect:password];
    if(flag){
        [myDelegate inputDone];
    }else{
        [self resetInput];
    }
}

-(void) resetInput
{
    for(UIButton *point in pointArray){
        [point setBackgroundColor:[UIColor clearColor]];
    }
    [inputArray removeAllObjects];
    [self shake];
}

-(void) shake
{
    UIView* pointsView = [self viewWithTag:POINTS_VIEW_TAG];
    
    CALayer *layer = [pointsView layer];
    CGPoint layerPosition = [layer position];
    CGPoint y = CGPointMake(layerPosition.x-10, layerPosition.y);
    CGPoint x = CGPointMake(layerPosition.x+10, layerPosition.y);
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [layer addAnimation:animation forKey:nil];
}

@end

#pragma mark - YLSPasswordButton

@implementation YLSPasswordButton

{
    NSString* buttonValue;
    UIColor *buttonColor;
    id<YLSPasswordButtonDelegate> myDelegate;
}

-(id) initWithTitle:(NSString*)title Value:(NSString*)value Color:(UIColor*)color Origin:(CGPoint)origin Delegate:(id<YLSPasswordButtonDelegate>)delegate
{
    self = [super init];
    
    if(self){
        
        buttonColor = color;
        buttonValue = value;
        myDelegate = delegate;
        
        // fixed button size, change it if needed. if you do so, also reset the frame in YLSSimplePasswordView
        self.$width = 80.0;
        self.$height = 80.0;
        self.$x = origin.x;
        self.$y = origin.y;
        
        // set CornerRadius to half of $width, so make the button circle
        [self.layer setCornerRadius:40.0];
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:buttonColor.CGColor];
        
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize: 32.0];
        
        [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// change background color when tapped
-(void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = buttonColor;
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

// YLSSimplePasswordView will handle this
-(void) pressed
{
    [myDelegate pressed:buttonValue];
}

@end