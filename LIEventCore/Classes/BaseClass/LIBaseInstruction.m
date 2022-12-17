//
//  LIBaseInstruction.m
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import "LIBaseInstruction.h"
#import "LIInstructionDependency.h"
@interface LIBaseInstruction()
@property (nonatomic,strong) NSMutableDictionary *dependencyDict;
@end
@implementation LIBaseInstruction
- (NSDictionary *)dependencyData {
    if (_dependencyDict == nil) {
        _dependencyDict = [NSMutableDictionary dictionary];
    }
    if (_dependencyDict.allKeys.count != 0) {
        return _dependencyDict;
    }
    for (LIInstructionDependency *dependency in [LIBaseInstruction dependencys]) {
        if (dependency.type == self.type) {
            for (LIInstructionDependencyData *data in dependency.datas) {
                if (data.number == self.number) {
                    for (LIDecisionDependencyString *str in data.dependencys) {
                        ///在这里进行关键词赋值
                        if ([str isEqualToString:LIDecisionStringWeather]) {
                            ///在这里把天气对应的参数传进去
                            _dependencyDict[str] = @"2";
                        } else if ([str isEqualToString:LIDecisionStringIntimacy]){
                            ///是其他参数的时候就填入其他的参数
                            _dependencyDict[str] = @"4.5";
                        }
                    }
                }
            }
        }
    }
    return _dependencyDict;
}

///从远端获取到的指令映射库
+ (NSArray <LIInstructionDependency *>*)dependencys {
    LIInstructionDependency *dependency = [[LIInstructionDependency alloc] init];
    dependency.type = 1;
    LIInstructionDependencyData *data = [[LIInstructionDependencyData alloc] init];
    data.number = 1001;
    data.dependencys = @[LIDecisionStringWeather,LIDecisionStringIntimacy];
    dependency.datas = @[data];
    return @[dependency];
}
@end
