//
//  LIEventData.m
//  Event
//
//  Created by 李佳楠 on 2022/12/19.
//

#import "LIEventData.h"
#import "LIEventCore.h"
@implementation LIEventData
///可以用的指令
+ (NSArray <LIBaseInstruction *>*)instructions {
    LIBaseInstruction *instruction = [[LIBaseInstruction alloc] init];
    instruction.type = 1;
    instruction.number = 1001;
    
    
//    LIBaseInstruction *instruction1 = [[LIBaseInstruction alloc] init];
//    instruction1.type = 1;
//    instruction1.number = 1002;
//    
//    LIBaseInstruction *instruction2 = [[LIBaseInstruction alloc] init];
//    instruction2.type = 1;
//    instruction2.number = 1003;
    return @[instruction];
}
///预存放的映射库
+ (NSArray <LIDecision *>*)decisions {
    LIDecision *decision = [[LIDecision alloc] init];
    decision.type = 1;
    LIDecisionData *data = [[LIDecisionData alloc] init];
    data.number = 1001;
    data.judgeSequencyArray = @[LIDecisionStringProbability];
    LIDecisionDetail *detail1 = [[LIDecisionDetail alloc] init];
    detail1.judgeString = @[@"[0,0.33)"];
    //    detail1.judgeString = @[@"(1,2)",@"(3,4)",@"[0,0.33)"];
    detail1.behaviorNumbers = @[@1001001,@1001002];
    detail1.priority = 1;
    
    LIDecisionDetail *detail2 = [[LIDecisionDetail alloc] init];
    detail2.judgeString = @[@"[0.33,0.67]"];
    //    detail2.judgeString = @[@"[2,3)",@"[4,5)",@"[0.33,0.67]"];
    detail2.behaviorNumbers = @[@1001002,@1001003];
    detail2.priority = 2;
    
    LIDecisionDetail *detail3 = [[LIDecisionDetail alloc] init];
//    detail3.judgeString = @[@"[3,4)",@"[5,6)",@"(0.67,1]"];
    detail3.judgeString = @[@"(0.67,1]"];
    detail3.behaviorNumbers = @[@1001003,@1001001];
    detail3.priority = 3;
    
    data.decisions = @[detail1,detail2,detail3];
    decision.datas = @[data];
    return @[decision];
}


///预存放的行为映射库
+ (NSArray<LIBaseBehavior *>*)behaviors {
    LIBaseBehavior *behavior1 = [[LIBaseBehavior alloc] init];
    behavior1.behaviorNumber = 1001001;
    behavior1.performerNumber = LIBehaviorPerformerMachineLight;
    
    LIBaseBehavior *behavior2 = [[LIBaseBehavior alloc] init];
    behavior2.behaviorNumber = 1001002;
    behavior2.performerNumber = LIBehaviorPerformerMachineHead;
    
    
    LIBaseBehavior *behavior3 = [[LIBaseBehavior alloc] init];
    behavior3.behaviorNumber = 1001003;
    behavior3.performerNumber = LIBehaviorPerformerPhoneAnimation;
    return @[behavior1,behavior2,behavior3];
}

///从远端获取到的指令映射库
+ (NSArray <LIInstructionDependency *>*)dependencys {
    LIInstructionDependency *dependency = [[LIInstructionDependency alloc] init];
    dependency.type = 1;
    LIInstructionDependencyData *data = [[LIInstructionDependencyData alloc] init];
    data.number = 1001;
    data.dependencys = @[LIDecisionStringProbability];
    dependency.datas = @[data];
    return @[dependency];
}

+ (NSMapTable <NSNumber*,id<LIEventRuningProtocol>>*)performers {
    return [LIEventCore performers];
}
@end
