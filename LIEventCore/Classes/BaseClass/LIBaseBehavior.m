//
//  LIBaseBehavior.m
//  LOOI
//
//  Created by 李佳楠 on 2022/12/2.
//

#import "LIBaseBehavior.h"
#import "LIEventData.h"
@interface LIBaseBehavior()
@property (nonatomic,weak) id<LIEventRuningProtocol> performer;
@end
@implementation LIBaseBehavior
- (void)setPerformerNumber:(LIBehaviorPerformerNumber)performerNumber {
    _performerNumber = performerNumber;
    self.performer = [[LIEventData performers] objectForKey:[NSNumber numberWithInt:performerNumber]];
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"/nbehaviorPerformerNumber:%d",self.performerNumber];
}
@end
