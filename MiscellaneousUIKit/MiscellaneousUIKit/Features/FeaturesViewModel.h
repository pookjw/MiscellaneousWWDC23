//
//  FeaturesViewModel.h
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import <UIKit/UIKit.h>
#import "FeaturesItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeaturesViewModel : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(UICollectionViewDiffableDataSource<NSNumber *, FeaturesItemModel *> *)dataSource;
- (void)loadDataSourceWithCompletionHandler:(void (^)(void))completionHandler;
- (void)itemModelFromIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^)(FeaturesItemModel * _Nullable))completionHandler;
@end

NS_ASSUME_NONNULL_END
