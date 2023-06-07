//
//  UniformAcrossSiblingsContentView.h
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import <UIKit/UIKit.h>
#import "UniformAcrossSiblingsContentConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniformAcrossSiblingsContentView : UIView <UIContentView>
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfiguration:(UniformAcrossSiblingsContentConfiguration *)configuration;
@end

NS_ASSUME_NONNULL_END
