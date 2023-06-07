//
//  UniformAcrossSiblingsContentConfiguration.h
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniformAcrossSiblingsContentConfiguration : NSObject <UIContentConfiguration>
@property (readonly, copy) NSString *imageName;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithImageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
