

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define kColor(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) || ( CGSizeEqualToSize(CGSizeMake(828, 1792),[[UIScreen mainScreen] currentMode].size)) || ( CGSizeEqualToSize(CGSizeMake(1242, 2688),[[UIScreen mainScreen] currentMode].size))) : NO)
