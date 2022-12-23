//
//  LIBaseInstruction.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIEventDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@interface LIBaseInstruction : NSObject
///类型
@property (nonatomic,assign) LIInstructionType type;
///编号
@property (nonatomic,assign) LIInstructionNumber number;
///数据
@property (nonatomic,copy,nullable) NSDictionary *data;
///依赖数据
- (NSDictionary <LIDecisionDependencyString*,NSString*>*)dependencyData;
@end

NS_ASSUME_NONNULL_END
