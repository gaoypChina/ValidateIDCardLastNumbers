//
//  IDCardView.h
//  GYPInputIDCard
//
//  Created by gyp on 2019/10/15.
//  Copyright © 2019 gyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDCardView : UIView

-(void)setValue:(NSString*)value;

@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) NSInteger length;

@end

NS_ASSUME_NONNULL_END
