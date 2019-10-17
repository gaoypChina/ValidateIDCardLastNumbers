
#import "InputIDCardVC.h"

#import "IDCardKeyboardView.h"
#import "IDCardView.h"
#import "IDCardConst.h"

#define ID_CARD_LENGTH 4

@interface InputIDCardVC ()<IDCardKeyboardViewDelegate>
{
    IDCardView *_idCardView;
    IDCardKeyboardView *_keyboardView;
}
@end

@implementation InputIDCardVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"安全验证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat bottom;
    {
        UIImageView *avatar = [UIImageView new];
        [self.view addSubview:avatar];
        avatar.frame = CGRectMake(0, 120, 96*0.8, 96*0.8);
        avatar.image = [UIImage imageNamed:@"id-card-user"];
        CGPoint center = avatar.center;
        center.x = SCREEN_SIZE.width /2.0;
        avatar.center = center;
        bottom = avatar.frame.origin.y + avatar.frame.size.height;
    }
    
    {
        UILabel *lblTitle = [UILabel new];
        [self.view addSubview:lblTitle];
        lblTitle.frame = CGRectMake(0, bottom  + 20, SCREEN_SIZE.width, 12);
        lblTitle.text = @"身份识别";
        lblTitle.font = [UIFont systemFontOfSize:18];
        lblTitle.textColor = [UIColor redColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        
        bottom = lblTitle.frame.origin.y + lblTitle.frame.size.height;
    }
    
    {
        UILabel *lblSubTitle = [UILabel new];
        [self.view addSubview:lblSubTitle];
        lblSubTitle.frame = CGRectMake(0, bottom  + 20, SCREEN_SIZE.width, 12);
        lblSubTitle.text = [NSString stringWithFormat:@"请输入您身份证号码的后%d位",ID_CARD_LENGTH];
        lblSubTitle.font = [UIFont systemFontOfSize:16];
        lblSubTitle.textColor = [UIColor darkTextColor];
        lblSubTitle.textAlignment = NSTextAlignmentCenter;
        
        bottom = lblSubTitle.frame.origin.y + lblSubTitle.frame.size.height;
    }
    
    {
        _idCardView = [IDCardView new];
        [self.view addSubview:_idCardView];
        {
            CGRect rect = _idCardView.frame;
            rect.origin.y = bottom + 40;
            _idCardView.frame = rect;
        }
        _idCardView.length = ID_CARD_LENGTH;
    }
 
    _keyboardView = [IDCardKeyboardView new];
    _keyboardView.delegate = self;
    _keyboardView.maxLength = ID_CARD_LENGTH;
    
    [self.view addSubview:_keyboardView];
}

#pragma mark - define method: callbacks

-(void)keyboardInputted:(NSMutableString *)string
{
    NSLog(@"idcard = %@",string);
    _idCardView.value = string;
}

- (void)keyboardReturn{
    NSString *value = _idCardView.value;
    if(value.length<ID_CARD_LENGTH){
        NSLog(@"长度必须为%d位",ID_CARD_LENGTH);
        return;
    }
    
    NSUInteger xLocation = [value rangeOfString:@"X"].location;
    if (xLocation != NSNotFound && xLocation != ID_CARD_LENGTH-1 ){
        NSLog(@"X必须在最后");
        return;
    }
    
    NSLog(@"keyboardReturn:%@",value);
}

@end
