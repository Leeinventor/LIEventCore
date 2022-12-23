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
    for (LIBaseBehavior *Behavior in self.behaviors) {
        if (Behavior.performer && Behavior.performer.runningType == LIRunningTypeReadyToStart) {
            [Behavior.performer startEvent:self behavior:Behavior];
        }
    }
    self.status = LIEventStatusDuring;
}
- (void)cancle {
    for (LIBaseBehavior *Behavior in self.behaviors) {
        [Behavior.performer cancleEvent:self behavior:Behavior];
    }
    self.status = LIEventStatusBeCancle;
}
///结束事件
- (void)end {
    BOOL isEnd = YES;
    for (LIBaseBehavior *Behavior in self.behaviors) {
        if (Behavior.performer && Behavior.performer.runningType == LIRunningTypeReadyToEnd) {
            [Behavior.performer endEvent:self behavior:Behavior];
        } else {
            isEnd = NO;
        }
    }
    self.status = isEnd ? LIEventStatusEnd : LIEventStatusDuring;
}
/// 强制结束事件
- (void)forceEnd {
    for (LIBaseBehavior *Behavior in self.behaviors) {
        [Behavior.performer forceEndEvent:self behavior:Behavior];
    }
    self.status = LIEventStatusEnd;
}
- (BOOL)canRun {
    for (LIBaseBehavior *behavior in self.behaviors) {
        if ([behavior.performer runningType] != LIRunningTypeReadyToStart) {
            return NO;
        }
    }
    self.status = LIEventStatusReadyToStart;
    return YES;
}
- (BOOL)isFinish {
    for (LIBaseBehavior *behavior in self.behaviors) {
        if ([behavior.performer runningType] == LIEventStatusDuring || [behavior.performer runningType] == LIEventStatusUnknown) {
            return NO;
        }
    }
    self.status = LIEventStatusEnd;
    return YES;
}
- (void)setStatus:(LIEventStatus)status {
    _status = status;
    if (_status == LIEventStatusReadyToStart) {
        self.startTimestamp = [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSince1970];
    }
    if (_status == LIEventStatusEnd || _status == LIEventStatusBeCancle) {
        self.endTimestamp = [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSince1970];
    }
}
- (NSString *)description {
    return [NSString stringWithFormat:@"\ninstructions:%@\nbehaviors:%@\nstarttimestamp:%@\nendTimeStamp:%@\npriority:%d",self.instructions,self.behaviors,self.startTimestamp,self.endTimestamp,self.priority];
}
@end
