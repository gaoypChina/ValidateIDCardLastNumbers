#import "ViewController.h"

#import "InputIDCardVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    InputIDCardVC *vc = [InputIDCardVC new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav
                       animated:NO completion:nil];
}

@end
