//
//  LIBaseBehavior.h
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import <Foundation/Foundation.h>
#import "LIEventRuningProtocol.h"
#import "LIEventDefinition.h"
NS_ASSUME_NONNULL_BEGIN

@interface LIBaseBehavior : NSObject
@property (nonatomic,assign) LIBehaviorNumber behaviorNumber;
///响应者
@property (nonatomic,assign) LIBehaviorPerformerNumber performerNumber;


/// 响应数据
/// 如果是LOOI响应就是指定的数据格式
/// 如果是mobile响应就是一串lottie的动画json
@property (nonatomic,copy) NSString *data;
///扩展数据，可为空
@property (nonatomic,strong,nullable) id extraData;


///执行者
- (id<LIEventRuningProtocol>)performer;
@end

NS_ASSUME_NONNULL_END
