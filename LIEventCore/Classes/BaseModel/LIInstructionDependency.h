//
//  LIInstructionDependency.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "LIEventDefinition.h"
NS_ASSUME_NONNULL_BEGIN
@class LIInstructionDependencyData;
@interface LIInstructionDependency : NSObject
///指令类型
@property (nonatomic,assign) LIInstructionType type;
@property (nonatomic,copy) NSArray <LIInstructionDependencyData *>* datas;
@end

@interface LIInstructionDependencyData : NSObject
///编号
@property (nonatomic,assign) LIInstructionNumber number;
///指令依赖参数
@property (nonatomic,copy,nonnull) NSArray<LIDecisionDependencyString *>* dependencys;
@end

NS_ASSUME_NONNULL_END
