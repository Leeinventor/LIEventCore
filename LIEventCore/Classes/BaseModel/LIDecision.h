//
//  LIDecision.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "LIEventDefinition.h"
NS_ASSUME_NONNULL_BEGIN
@class LIDecisionData;
@class LIDecisionDetail;
@interface LIDecision : NSObject
///指令类型
@property (nonatomic,assign) LIInstructionType type;
@property (nonatomic,copy) NSArray <LIDecisionData *>* datas;
@end

@interface LIDecisionData : NSObject
///编号
@property (nonatomic,assign) LIInstructionNumber number;
/**
 依赖判断顺序数组和依赖判LIDecisionDetail内judgeString的内数据一一对应
 如依赖判断顺序数组内容为  @[@"weather",@"intimacy"]
 LIDecisionDetail内judgeString的数组应为 @[@"1",@"(0,3)"]
 确保一一对应
 */

///依赖判断顺序
@property (nonatomic,copy) NSArray <LIDecisionDependencyString *>* judgeSequencyArray;
///依赖判断
@property (nonatomic,copy) NSArray <LIDecisionDetail *>*decisions;

@end

@interface LIDecisionDetail : NSObject
///有两种判断模式，区间，等于
///如果为区间判断数据格式为
///“(1,2)”，意思就是大于1小于2之间
///“[1,2]”，意思就是大于等于1小于等于2之间
///“1”,意思即为等于1
@property (nonatomic,copy) NSArray<LIDecisionJudgeString *> *judgeString;
///优先级 数字从小到大，数字越大优先级越高
@property (nonatomic,assign) NSInteger priority;
///行为编号组
@property (nonatomic,copy) NSArray * behaviorNumbers;
@end
NS_ASSUME_NONNULL_END
