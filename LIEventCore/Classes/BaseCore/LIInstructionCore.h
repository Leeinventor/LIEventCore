//
//  LIInstructionCore.h
//  Event
//
//  Created by 李佳楠 on 2022/12/17.
//

#import <Foundation/Foundation.h>
#import "LIBaseInstruction.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIInstructionCore : NSObject
///判断指令是否合法
+ (BOOL)isInstructionLegal:(NSArray <LIBaseInstruction *>*)instructions;
@end

NS_ASSUME_NONNULL_END
