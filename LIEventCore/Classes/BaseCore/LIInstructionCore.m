//
//  LIInstructionCore.m
//  Event
//
//  Created by 李佳楠 on 2022/12/17.
//

#import "LIInstructionCore.h"

@implementation LIInstructionCore
///判断指令是否合法
+ (BOOL)isInstructionLegal:(NSArray <LIBaseInstruction *>*)instructions {
    
    for (LIBaseInstruction *instruction in instructions) {
        ///默认不合法
        BOOL unLegal = YES;
        for (LIBaseInstruction *legalInstruction in [LIEventData instructions]) {
            ///在可用的指令集中存在一致的，那这个指令就合法
            if (instruction.type == legalInstruction.type && instruction.number == legalInstruction.number) {
                unLegal = NO;
            }
        }
        //如果任意一个指令不合法就返回不合法
        if (!unLegal) {
            return YES;
        }
    }
    return NO;
}

@end
