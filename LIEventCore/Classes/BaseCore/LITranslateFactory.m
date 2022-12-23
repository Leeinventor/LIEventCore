//
//  LITranslateFactory.m
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import "LITranslateFactory.h"
#import "LIDecisionCore.h"
#import "LIInstructionCore.h"
@implementation LITranslateFactory
///转换为事件
+ (nullable LIEvent *)translate:(NSArray <LIBaseInstruction *>*)instructions {
    NSMutableArray *array = [NSMutableArray array];
    ///先校验所有的指令是否合法
    if (![LIInstructionCore isInstructionLegal:instructions]) {
        ///指令不合法，返回空事件
        return nil;
    }
    NSInteger priority = -99;
    ///获取指令组下所有行为组
    for (LIBaseInstruction *instruction in instructions) {
        ///通过指令获取指定的行为编码组
        LIDecisionDetail *detail = [LIDecisionCore getBehaviorNumbers:instruction];
        ///通过行为编码组获取所有的行为
        for (NSNumber *number in detail.behaviorNumbers) {
            LIBaseBehavior *behavior = [LIDecisionCore getBehaviorWithNumber:number.integerValue];
            [array addObject:behavior];
        }
        priority = detail.priority;
    }
    ///有行为组才有效
    if (array.count != 0) {
        LIEvent *event = [[LIEvent alloc] init];
        event.instructions = instructions;
        event.behaviors = array;
        event.priority = priority;
        event.startTimestamp = [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSince1970];
        return event;
    }
    return nil;
}


@end
