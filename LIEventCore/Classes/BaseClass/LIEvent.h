//
//  LIEvent.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIBaseBehavior.h"
#import "LIBaseInstruction.h"
#import "LIEventDefinition.h"
NS_ASSUME_NONNULL_BEGIN

///事件状态
typedef NS_ENUM(NSUInteger, LIEventStatus) {
    ///未知状态
    LIEventStatusUnknown = 0,
    ///等待开始
    LIEventStatusReadyToStart = 1,
    ///进行中
    LIEventStatusDuring,
    ///结束
    LIEventStatusEnd,
    ///被取消
    LIEventStatusBeCancle
};
@interface LIEvent : NSObject
///指令组
@property (nonatomic,strong) NSArray<LIBaseInstruction *>*instructions;
///行为组
@property (nonatomic,strong) NSArray<LIBaseBehavior *>*behaviors;
///开始时间
@property (nonatomic,copy) NSString *startTimestamp;
///结束时间
@property (nonatomic,copy) NSString *endTimestamp;
///事件状态
@property (nonatomic,assign) LIEventStatus status;
///优先级 数字从小到大，数字越大优先级越高
@property (nonatomic,assign) NSInteger priority;
///开启事件
- (void)start;
///取消事件
- (void)cancle;
///结束事件
- (void)end;
///强制结束事件
- (void)forceEnd;
///可以执行
- (BOOL)canRun;
///是否执行结束
- (BOOL)isFinish;
@end

NS_ASSUME_NONNULL_END
