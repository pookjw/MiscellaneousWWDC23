//
//  FeaturesItemModel.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "FeaturesItemModel.h"

@interface FeaturesItemModel ()
@property (assign) FeaturesItemModelType type;
@end

@implementation FeaturesItemModel

- (instancetype)initWithType:(FeaturesItemModelType)type {
    if (self = [self init]) {
        self.type = type;
    }
    
    return self;
}

- (NSUInteger)hash {
    return self.type;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else if ([other isKindOfClass:FeaturesItemModel.class]) {
        return self.type == ((FeaturesItemModel *)other).type;
    } else {
        return NO;
    }
}

@end
