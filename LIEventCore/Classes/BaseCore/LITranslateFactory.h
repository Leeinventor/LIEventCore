//
//  LITranslateFactory.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIEvent.h"
#import "LIEventDefinition.h"
NS_ASSUME_NONNULL_BEGIN
///指令组变为事件
@interface LITranslateFactory : NSObject
/// 指令组转换为事件 当返回为nil时，代表当前指令被抛弃不执行
/// @param instructions 指令组
+ (nullable LIEvent *)translate:(NSArray <LIBaseInstruction *>*)instructions;
@end

NS_ASSUME_NONNULL_END
