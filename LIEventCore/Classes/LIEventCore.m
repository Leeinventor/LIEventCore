//
//  LIEventCore.m
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import "LIEventCore.h"
#import "LITranslateFactory.h"
@interface LIEventCore()
///正在执行的事件们
@property (strong) NSMutableArray <LIEvent *> *currentEvents;

@property (strong) NSMutableArray <LIEvent *> *historyEvents;

@property (strong) NSMutableArray <LIEvent *> *cacheEvents;

@property (nonatomic,strong) NSMapTable <NSNumber*,id<LIEventRuningProtocol>>* performers;
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
        _currentEvents = [NSMutableArray array];
        _historyEvents = [NSMutableArray array];
        _cacheEvents = [NSMutableArray array];
    }
    return self;
}

///输入一个指令流
+ (void)inputInstructions:(NSArray <LIBaseInstruction *>*)instructions {
    LIEvent *event = [LITranslateFactory translate:instructions];
    if (event == nil) {
        return;
    }
    ///如果事件可以执行
    if ([event canRun]) {
        ///直接执行事件
        [LIEventCore beginEvent:event];
    } else {
        NSArray *currentEvents = [LIEventCore manager].currentEvents;
        ///遍历当前正在执行的所有事件
        for (LIEvent *currentEvent in currentEvents) {
            ///如果事件比正在执行的事件优先级高的话
            if (event.priority > currentEvent.priority) {
                ///遍历正在执行事件的所有执行者，如果有和当前事件的执行者一致的，强制结束正在执行的事件的执行者
                [currentEvent.behaviors enumerateObjectsUsingBlock:^(LIBaseBehavior * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    for (LIBaseBehavior *behavior in event.behaviors) {
                        if (behavior.performerNumber == obj.performerNumber) {
                            [obj.performer forceEndEvent:currentEvent behavior:obj];
                        }
                    }
                }];
            }
        }
        ///再次判断事件是否可以执行
        if ([event canRun]) {
            //执行事件
            [LIEventCore beginEvent:event];
        } else {
            ///加入到缓存事件组中，等待可以执行
            [[LIEventCore manager].cacheEvents addObject:event];
        }
    }

}
///执行者结束执行
+ (void)performerDidFinishRunning:(id <LIEventRuningProtocol>)performer {
    if (performer == nil || ![performer conformsToProtocol:@protocol(LIEventRuningProtocol)]) {
        return;
    }
    NSMutableArray *finishEvents = [NSMutableArray array];
    NSMutableArray *currentEvents = [LIEventCore manager].currentEvents;
    NSMutableArray *historyEvents = [LIEventCore manager].historyEvents;
    NSMutableArray *cacheEvents = [LIEventCore manager].cacheEvents;
    NSMutableArray *nextRunEvents = [NSMutableArray array];
    for (LIEvent *event in currentEvents) {
        if ([event isFinish]) {
            NSLog(@"%@\n这个事件执行结束",event);
            [finishEvents addObject:event];
        }
    }
    if (finishEvents.count != 0) {
        [currentEvents removeObjectsInArray:finishEvents];
        [historyEvents addObjectsFromArray:finishEvents];
    }
    for (LIEvent *event in cacheEvents) {
        if ([event canRun]) {
            [LIEventCore beginEvent:event];
            [nextRunEvents addObject:event];
        }
    }
    if (nextRunEvents.count != 0) {
        [cacheEvents removeObjectsInArray:nextRunEvents];
    }
    NSLog(@"--------------当前正在执行数组数据有：%d 当前缓存数组数据有：%d 当前历史数组数据有：%d --------------",currentEvents.count,cacheEvents.count,historyEvents.count);
    if (currentEvents.count == 2) {
        NSLog(@"正在执行数组为：%@",currentEvents);
    }
    if (currentEvents.count == 0) {
        [historyEvents removeAllObjects];
    }
}
///设置执行者
+ (void)setPerformers:(NSMapTable <NSNumber*,id<LIEventRuningProtocol>>*)performer {
    LIEventCore *core = [LIEventCore manager];
    core.performers = performer;
}

+ (NSMapTable <NSNumber*,id<LIEventRuningProtocol>>*)performers {
    return [LIEventCore manager].performers;
}




+ (void)beginEvent:(LIEvent *)event {
    LIEventCore *core = [LIEventCore manager];
    if ([core.currentEvents containsObject:event]) {
        return;
    }
    [core.currentEvents addObject:event];
    [event start];
    NSLog(@"%@\n这个事件开始执行",event);
}
///停止当前事件
+ (void)stopCurrenEvent {
    LIEventCore *core = [LIEventCore manager];
    for (LIEvent *event in core.currentEvents) {
        if (![core.historyEvents containsObject:event]) {
            [core.historyEvents addObject:event];
        }
        [event forceEnd];
    }
    [core.currentEvents removeAllObjects];
}

///历史事件
+ (NSArray <LIEvent *>*)historyEvents {
    return [LIEventCore manager].historyEvents;
}
@end
