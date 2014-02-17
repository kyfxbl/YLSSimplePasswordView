#import "ScreenLockViewController.h"

@implementation ScreenLockViewController

-(void) loadView
{
    YLSSimplePasswordView *passwordView = [[YLSSimplePasswordView alloc] initWithDelegate:self];
    self.view = passwordView;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.view.superview.backgroundColor = [UIColor clearColor];
}

#pragma mark - YLSSimplePasswordViewDelegate method

-(BOOL) passwordCorrect:(NSString*)input
{
    if([input isEqualToString:@"1111"]){
        return YES;
    }
    return NO;
}

-(void) inputDone
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
