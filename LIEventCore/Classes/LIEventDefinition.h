//
//  LIEventDefinition.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/16.
//

#ifndef LIEventDefinition_h
#define LIEventDefinition_h
///指令类别
typedef NSInteger LIInstructionType;
///指令编号
typedef NSInteger LIInstructionNumber;
///行为编号
typedef NSInteger LIBehaviorNumber;
/**
 举例：
 指令类型为1
 指令编号就为1000X
 指令编号是基于指令类型进行编码
 指令编号中1是指对应的指令类型为1，000是代表中间占位符，X代表对应的编号
 */
///决策依赖参数
typedef NSString LIDecisionDependencyString;
///决策判断参数
typedef NSString LIDecisionJudgeString;

///天气参数
static LIDecisionDependencyString * const LIDecisionStringWeather = @"weather";
///亲密度参数
static LIDecisionDependencyString * const LIDecisionStringIntimacy = @"intimacy";

#endif /* LIEventDefinition_h */
