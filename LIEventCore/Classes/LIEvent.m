//
//  LIEvent.m
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import "LIEvent.h"

@implementation LIEvent
///开启事件
- (void)start {
    for (LIBaseBehavior *Behavior in self.Behaviors) {
        if (Behavior.performer && Behavior.performer.runningType == LIRunningTypeReadyToStart) {
            [Behavior.performer start:Behavior];
        }
    }
    self.status = LIEventStatusDuring;
}
- (void)cancle {
    for (LIBaseBehavior *Behavior in self.Behaviors) {
        [Behavior.performer cancle:Behavior];
    }
    self.status = LIEventStatusBeCancle;
}
///结束事件
- (void)end {
    BOOL isEnd = YES;
    for (LIBaseBehavior *Behavior in self.Behaviors) {
        if (Behavior.performer && Behavior.performer.runningType == LIRunningTypeReadyToEnd) {
            [Behavior.performer end:Behavior];
        } else {
            isEnd = NO;
        }
    }
    self.status = isEnd ? LIEventStatusEnd : LIEventStatusDuring;
}
/// 强制结束事件
- (void)forceEnd {
    for (LIBaseBehavior *Behavior in self.Behaviors) {
        [Behavior.performer end:Behavior];
    }
    self.status = LIEventStatusEnd;
    [[NSNotificationCenter defaultCenter] postNotificationName:LIEventDidForceEnd object:nil];
}
@end
