
#import "IDCardView.h"

#import "IDCardConst.h"

#define MY_HEIGHT 48
#define k_TextColor170 kColor(170, 170, 170, 1)

@interface IDCardView()
{
    NSArray *_arrLabels;
}
@end;

@implementation IDCardView

-(instancetype)init{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.frame = CGRectMake(0, 0, SCREEN_SIZE.width, MY_HEIGHT);
    self.value = @"";
    self.length = 4;
    [self createViews];
    
    return self;
}

#pragma mark - 构建界面相关 -

-(void)createViews{
    
    CGFloat itemWidth = 43;
    CGFloat space = (SCREEN_SIZE.width - 106 - 43*self.length)/(self.length-1);
    NSMutableArray *arrLabels = @[].mutableCopy;
    for (int i = 0; i < self.length; i ++) {
        CGRect frame = CGRectMake(i*(space + itemWidth) + 53, 0, itemWidth, MY_HEIGHT);
        UILabel *lblOneChar = [[UILabel alloc] initWithFrame:frame];
        lblOneChar.textAlignment = NSTextAlignmentCenter;
        lblOneChar.layer.borderWidth = 1;
        lblOneChar.layer.borderColor = k_TextColor170.CGColor;
        lblOneChar.userInteractionEnabled = NO;
        lblOneChar.layer.cornerRadius = 5;
        [self addSubview:lblOneChar];
        lblOneChar.font = [UIFont systemFontOfSize:20];
        lblOneChar.textColor = [UIColor darkTextColor];
        
        [arrLabels addObject:lblOneChar];
    }
    
    _arrLabels = arrLabels.copy;
}

#pragma mark - Public -

-(void)setValue:(NSString*)value{
    _value = value;
    if(value.length>self.length){
        _value = [value substringToIndex:self.length];
    }
    for(int i=0;i<self.length;i++){
        UILabel *label = _arrLabels[i];
        
        if(value.length>0 && i<=value.length-1){
            NSString *chart = [value substringWithRange:NSMakeRange(i, 1)];
            label.text = chart;
        }else{
            label.text = @"";
        }
        
        if(i == value.length){
            label.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            label.layer.borderColor = k_TextColor170.CGColor;
        }
    }
}

@end
