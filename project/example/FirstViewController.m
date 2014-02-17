#import "FirstViewController.h"

@implementation FirstViewController

-(void) loadView
{
    UIView *rootView = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(412, 200, 200, 40)];
    label.text = @"example";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:32.0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(464, 400, 100, 40);
    [button setTitle:@"click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    [rootView addSubview:label];
    [rootView addSubview:button];
    
    self.view = rootView;
}

-(void) click
{
    ScreenLockViewController *screenLockViewController = [[ScreenLockViewController alloc] init];
    screenLockViewController.modalPresentationStyle = UIModalPresentationFormSheet;// modal window
        
    [self presentViewController:screenLockViewController animated:YES completion:nil];
}

@end
