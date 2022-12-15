//
//  LIEventCore.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIEvent.h"
#import "LIEventDataProvider.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIEventCore : NSObject
///输入一个指令流
+ (void)inputInstructions:(NSArray <LIBaseInstruction *>*)instructions;
///停止执行当前事件
+ (void)stopCurrenEvent;
///当前正在执行的事件
+ (LIEvent *)currentEvent;
///设置数据提供代理
+ (void)setDataProvider:(id<LIEventDataProvider>)provider;
///设置历史记录时间，默认记录最近十分钟
+ (void)setHistoryEventLast:(NSInteger)time;
///历史事件
+ (NSArray <LIEvent *>*)historyEvents;

@end

NS_ASSUME_NONNULL_END
