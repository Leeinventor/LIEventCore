//
//  LIEventRuningProtocol.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LIRunningType) {
    ///未知状态
    LIRunningTypeUnknown,
    ///准备开始
    LIRunningTypeReadyToStart,
    ///进行中
    LIRunningTypeDuring,
    ///准备结束
    LIRunningTypeReadyToEnd,
    ///结束
    LIRunningTypeEnd
};
@class LIBaseBehavior;
@class LIEvent;
@protocol LIEventRuningProtocol <NSObject>
@required
///开始
- (void)startEvent:(LIEvent *)event behavior:(LIBaseBehavior *)behavior;
///取消
- (void)cancleEvent:(LIEvent *)event behavior:(LIBaseBehavior *)behavior;
///结束
- (void)endEvent:(LIEvent *)event behavior:(LIBaseBehavior *)behavior;
///强制停止
- (void)forceEndEvent:(LIEvent *)event behavior:(LIBaseBehavior *)behavior;
/// 运行状态
- (LIRunningType)runningType;
@end

NS_ASSUME_NONNULL_END
