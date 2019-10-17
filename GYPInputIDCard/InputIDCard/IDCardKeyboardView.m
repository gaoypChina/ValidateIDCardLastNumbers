
#import "IDCardKeyboardView.h"
#import "UIImage+STint.h"
#import "IDCardConst.h"

//键盘的高度。在iPhoneX时，不包括底部安全区的高度。
#define KEYBOARD_HEIGHT 216

@interface IDCardKeyboardView ()


//键盘的键帽列表
@property (nonatomic, strong) NSArray *arrKeyCap;
//已经输入的字符串
@property (nonatomic, strong) NSMutableString *string;
@end

@implementation IDCardKeyboardView

-(instancetype)init
{
    self = [super init];
    if (!self){
        return nil;
    }
    
    {
        CGFloat height = KEYBOARD_HEIGHT;
        if(IS_iPhoneX){
            height += 34;
        }
        self.frame = CGRectMake(0, SCREEN_SIZE.height - height, SCREEN_SIZE.width, height);
    }
    
    self.backgroundColor = [UIColor lightTextColor];
    
    self.maxLength = 4;
    self.string = [NSMutableString string];
    self.arrKeyCap = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"X",@"0"];
    
    [self createButtons];
    
    return self;
}

#pragma mark - Public -

#pragma mark - 构建界面相关 -

- (void)createButtons
{
    int index = 0;
    //4行3列
    float buttonWidth = (SCREEN_SIZE.width - 100) / 3;
    float buttonHeight = KEYBOARD_HEIGHT / 4;
    float padding = 0;
    
    //创建按钮
    for(int rowIndex = 0; rowIndex < 4; rowIndex++)
    {
        float y = rowIndex*(buttonHeight + padding);
        
        for(int colIndex = 0; colIndex < 3; colIndex++)
        {
            if(index>=_arrKeyCap.count){
                break;
            }
            
            float x = colIndex*(buttonWidth + padding);
            UIButton *button = [self addButtonWithTitle:_arrKeyCap[index]
                                                  frame:CGRectMake(x, y, buttonWidth, buttonHeight)];
            [button addTarget:self
                       action:@selector(onClick:)
             forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:button];
            
            index++;
        }
    }
    
    //删除按钮
    {
        CGRect frame = CGRectMake(buttonWidth*3, 0, 100, KEYBOARD_HEIGHT/2);
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:frame];
        [self addSubview:deleteButton];
        [deleteButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [deleteButton setTitle:@"⌫" forState:UIControlStateNormal];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:30];
        [deleteButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]
                                forState:UIControlStateNormal];
        [deleteButton addTarget:self
                         action:@selector(onDeleteButton:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    
    //确定按钮
    {
        CGRect frame = CGRectMake(buttonWidth*3, KEYBOARD_HEIGHT/2, 100, KEYBOARD_HEIGHT/2);
        UIButton *sureButton = [[UIButton alloc] initWithFrame:frame];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.02 green:0.65 blue:0.97 alpha:1.00]]
                              forState:UIControlStateNormal];
        [sureButton addTarget:self
                       action:@selector(onSureButton:)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButton];
    }
    
    //画线。如果每一个button都绘边线则相邻两个按钮的边线会重合。
    {
        //横线
        for (int i = 0; i<5; i++){
            UIBezierPath *hLinePath = [UIBezierPath bezierPath];
            [hLinePath moveToPoint:CGPointMake(0, i * buttonHeight)];
            
            CGFloat endX = self.frame.size.width;
            if(i==1 || i == 3){
                endX = buttonWidth * 3;
            }
            [hLinePath addLineToPoint:CGPointMake(endX, i * buttonHeight)];
            [self addLineWithPath:hLinePath.CGPath];
        }
        
        // 竖线
        for (int i = 1; i<4; i++){
            UIBezierPath *vLinePath = [UIBezierPath bezierPath];
            [vLinePath moveToPoint:CGPointMake(i * buttonWidth, 0)];
            [vLinePath addLineToPoint:CGPointMake(i * buttonWidth, buttonHeight*4)];
            [self addLineWithPath:vLinePath.CGPath];
        }
    }
    
}

#pragma mark - 事件处理 -

- (void)onClick:(UIButton *)button
{
    if(self.string.length>=self.maxLength){
        return;
    }
    
    [self.string appendString:button.currentTitle];
    if ([self.delegate respondsToSelector:@selector(keyboardInputted:)])
    {
        [self.delegate keyboardInputted:self.string];
    }
}

-(void)onDeleteButton:(id)sender
{
    if (self.string.length > 0) {
        [self.string deleteCharactersInRange:NSMakeRange(self.string.length-1, 1)];
        if ([self.delegate respondsToSelector:@selector(keyboardInputted:)])
        {
            [self.delegate keyboardInputted:self.string];
        }
    }
}

-(void)onSureButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(keyboardReturn)]) {
        [_delegate keyboardReturn];
    }
}


#pragma mark - 工具方法 -

- (UIButton *)addButtonWithTitle:(NSString *)title
                           frame:(CGRect)frame_rect
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame_rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]
                            forState:UIControlStateNormal];
    
    return button;
}

- (void)addLineWithPath:(CGPathRef)path{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    layer.fillColor = nil;
    layer.path = path;
    layer.lineWidth = 0.5;
    [self.layer addSublayer:layer];
}

@end

