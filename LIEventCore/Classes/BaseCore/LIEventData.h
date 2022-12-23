//
//  LIEventData.h
//  Event
//
//  Created by 李佳楠 on 2022/12/19.
//

#import <Foundation/Foundation.h>
#import "LIBaseInstruction.h"
#import "LIDecision.h"
#import "LIBaseBehavior.h"
#import "LIInstructionDependency.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIEventData : NSObject
///可以用的指令
+ (NSArray <LIBaseInstruction *>*)instructions;
///预存放的决策映射库
+ (NSArray <LIDecision *>*)decisions;
///预存放的行为映射库
+ (NSArray <LIBaseBehavior *>*)behaviors;
///从远端获取到的指令映射库
+ (NSArray <LIInstructionDependency *>*)dependencys;
///预先设置的执行者映射
+ (NSMapTable <NSNumber*,id<LIEventRuningProtocol>>*)performers;
@end

NS_ASSUME_NONNULL_END
