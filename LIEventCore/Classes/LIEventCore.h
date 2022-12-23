//
//  LIEventCore.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIEvent.h"
#import "LIEventDefinition.h"
#import "LIEventRuningProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIEventCore : NSObject
///输入一个指令流
+ (void)inputInstructions:(NSArray <LIBaseInstruction *>*)instructions;
///设置执行者
+ (void)setPerformers:(NSMapTable <NSNumber*,id<LIEventRuningProtocol>>*)performers;
///执行者们
+ (NSMapTable <NSNumber*,id<LIEventRuningProtocol>>*)performers;
///执行者结束执行
+ (void)performerDidFinishRunning:(id <LIEventRuningProtocol>)performer;
///停止执行当前事件
+ (void)stopCurrenEvents;
/// 正在执行的事件们
+ (NSArray <LIEvent *>*)currentEvents;
///历史事件
+ (NSArray <LIEvent *>*)historyEvents;

@end

NS_ASSUME_NONNULL_END
