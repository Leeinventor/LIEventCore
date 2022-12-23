//
//  LIDecisionCore.m
//  Event
//
//  Created by 李佳楠 on 2022/12/17.
//

#import "LIDecisionCore.h"

@implementation LIDecisionCore
///根据指令获取对应的行为组编码
+ (LIDecisionDetail *)getBehaviorNumbers:(LIBaseInstruction *)instruction {
    ///获取决策组
    NSArray <LIDecision *>* decisions = [LIEventData decisions];
    
    for (LIDecision *decision in decisions) {
        //匹配类型
        if (decision.type == instruction.type) {
            ///获取类型下所有的编码指令
            for (LIDecisionData *data in decision.datas) {
                ///对比准确指令
                if (data.number == instruction.number) {
                    ///判断是否有依赖数据
                    if (instruction.dependencyData != nil) {
                        ///对依赖数据依序进行判断用以获取指定范围内的行为组
                        for (LIDecisionDetail *detail in data.decisions) {
                            ///是否在范围内
                            BOOL isIn = YES;
                            for (int i = 0; i < detail.judgeString.count; i++) {
                                ///获取要判断的key
                                NSString *judgeKey = data.judgeSequencyArray[i];
                                ///获取要判断的数据
                                NSString *judgeString = instruction.dependencyData[judgeKey];
                                ///获取要判断的范围
                                NSString *range = detail.judgeString[i];
                                ///进行判断是否在范围内
                                isIn = [LIDecisionCore judgeString:judgeString atRange:range];
                                if (!isIn) {
                                    break;
                                }
                            }
                            ///如果所有的都在范围内就返回当前行为组
                            if (isIn) {
                                return detail;
                            }
                        }
                    }
                }
            }
        }
    }
    return nil;
}
///通过行为编码获取指定的行为
+ (LIBaseBehavior *)getBehaviorWithNumber:(LIBehaviorNumber)number {
    ///在这里通过number从一个数据体里面获取对应的行为个体
    NSArray <LIBaseBehavior *>* behaviors = [LIEventData behaviors];
    for (LIBaseBehavior *behavior in behaviors) {
        if (behavior.behaviorNumber == number) {
            return behavior;
        }
    }
    return nil;
}

///判断数据是否在指定的范围内
+ (BOOL)judgeString:(NSString *)judgeString atRange:(NSString *)range {
    if ([judgeString isEqualToString:range]) {
        return YES;
    } else {
        NSArray *array = [range componentsSeparatedByString:@","];
        float first = [[array.firstObject substringWithRange:NSMakeRange(1, [array.firstObject length] - 1)] floatValue];
        float last = [array.lastObject floatValue];
        float judge = judgeString.floatValue;
        if ([array.firstObject hasPrefix:@"("] && [array.lastObject hasSuffix:@")"]) {
            if (judge > first && judge < last) {
                return YES;
            }
        } else if ([array.firstObject hasPrefix:@"["] && [array.lastObject hasSuffix:@"]"]) {
            if (judge == first || judge == last) {
                return YES;
            }
            if (judge > first && judge < last) {
                return YES;
            }
        } else if ([array.firstObject hasPrefix:@"("] && [array.lastObject hasSuffix:@"]"]) {
            if (judge == last) {
                return YES;
            }
            if (judge > first && judge < last) {
                return YES;
            }
        } else if ([array.firstObject hasPrefix:@"["] && [array.lastObject hasSuffix:@")"]) {
            if (judge == first) {
                return YES;
            }
            if (judge > first && judge < last) {
                return YES;
            }
        }
    }
    return NO;
}

@end
