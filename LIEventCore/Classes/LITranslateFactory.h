//
//  LITranslateFactory.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIEvent.h"
NS_ASSUME_NONNULL_BEGIN
///指令组转换为反馈组工厂
@interface LITranslateFactory : NSObject
///转换为事件
+ (LIEvent *)translate:(NSArray <LIBaseInstruction *>*)instructions;
@end

NS_ASSUME_NONNULL_END
