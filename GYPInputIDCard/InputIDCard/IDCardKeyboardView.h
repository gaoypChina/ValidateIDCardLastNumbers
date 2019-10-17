
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IDCardKeyboardView;

@protocol IDCardKeyboardViewDelegate<NSObject>
@optional
// 点击键盘输入字符时的回调
- (void)keyboardInputted:(NSMutableString *)string;
//点击确定按钮时的回调
- (void)keyboardReturn;
@end

@interface IDCardKeyboardView : UIView

@property (nonatomic, assign) id<IDCardKeyboardViewDelegate> delegate;
@property (nonatomic, assign) NSInteger maxLength;

@end
