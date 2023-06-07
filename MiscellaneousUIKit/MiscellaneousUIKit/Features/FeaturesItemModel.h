//
//  FeaturesItemModel.h
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FeaturesItemModelType) {
    FeaturesItemModelTypeContentUnavailableView,
    FeaturesItemModelTypeShape,
    FeaturesItemModelTypeUniformAcrossSiblings,
    FeaturesItemModelTypePageControl
};

@interface FeaturesItemModel : NSObject
@property (readonly, assign) FeaturesItemModelType type;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(FeaturesItemModelType)type;
@end

NS_ASSUME_NONNULL_END
