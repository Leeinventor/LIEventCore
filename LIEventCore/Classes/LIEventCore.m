//
//  LIEventCore.m
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import "LIEventCore.h"
#import "LITranslateFactory.h"
@interface LIEventCore()
///事件过期时间，默认12H
@property (nonatomic,assign) NSInteger expirationTime;
///正在执行的事件
@property (nonatomic,strong) LIEvent *event;

@property (nonatomic,strong) NSMutableArray <LIEvent *> *historyEvents;
@end
@implementation LIEventCore
+(instancetype)manager {
    static LIEventCore *core;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[LIEventCore alloc] init];
    });
    return core;
}
- (instancetype)init {
    if (self = [super init]) {
        _expirationTime = 60 * 60 * 12;
    }
    return self;
}
///输入一个指令流
+ (void)inputInstructions:(NSArray <LIBaseInstruction *>*)instructions {
    LIEvent *event = [LITranslateFactory translate:instructions];
    NSLog(@"%@",event);
//    if (event) {
//        if (event.priority > [LIEventCore currentEvent].priority) {
//            [LIEventCore stopCurrenEvent];
//            [LIEventCore beginEvent:event];
//        } else if (event.priority == [LIEventCore currentEvent].priority) {
//
//        }
//    }
    
    
}
+ (void)beginEvent:(LIEvent *)event {
    LIEventCore *core = [LIEventCore manager];
    core.event = event;
    [event start];
}
///停止当前事件
+ (void)stopCurrenEvent {
    LIEventCore *core = [LIEventCore manager];
    if (core.historyEvents.count > 19) {
        [core.historyEvents removeObjectAtIndex:0];
    }
    [core.historyEvents addObject:core.event];
    [core.event forceEnd];
}

///当前正在执行的事件
+ (LIEvent *)currentEvent {
    return [LIEventCore manager].event;
}
///设置历史记录时间，默认记录最近十分钟
+ (void)setHistoryEventLast:(NSInteger)time {
    [LIEventCore manager].expirationTime = time;
}

///历史事件
+ (NSArray <LIEvent *>*)historyEvents {
    return [LIEventCore manager].historyEvents;
}

- (NSMutableArray <LIEvent *>*)historyEvents {
    if (!_historyEvents) {
        _historyEvents = [NSMutableArray arrayWithCapacity:20];
    }
    return _historyEvents;
}

@end
