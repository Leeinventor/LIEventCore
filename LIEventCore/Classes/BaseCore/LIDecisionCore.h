//
//  LIDecisionCore.h
//  Event
//
//  Created by 李佳楠 on 2022/12/17.
//

#import <Foundation/Foundation.h>
#import "LIBaseInstruction.h"
#import "LIDecision.h"
#import "LIBaseBehavior.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIDecisionCore : NSObject
///根据指令获取对应的行为组编码
+ (NSArray *)getBehaviorNumbers:(LIBaseInstruction *)instruction;
///通过行为编码获取指定的行为
+ (LIBaseBehavior *)getBehaviorWithNumber:(LIBehaviorNumber)number;
///判断数据是否在指定的范围内
+ (BOOL)judgeString:(NSString *)judgeString atRange:(NSString *)range;
@end

NS_ASSUME_NONNULL_END
