//
//  FeaturesViewModel.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "FeaturesViewModel.h"

@interface FeaturesViewModel ()
@property (retain) UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> *dataSource;
@property (retain) NSOperationQueue *queue;
@end

@implementation FeaturesViewModel

- (instancetype)initWithDataSource:(UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> *)dataSource {
    if (self = [self init]) {
        self.dataSource = dataSource;
        [self setupQueue];
    }
    
    return self;
}

- (void)dealloc {
    [_queue cancelAllOperations];
    [_queue release];
    [_dataSource release];
    [super dealloc];
}

- (void)loadDataSourceWithCompletionHandler:(void (^)(void))completionHandler {
    UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> *dataSource = self.dataSource;
    
    [self.queue addOperationWithBlock:^{
        NSDiffableDataSourceSnapshot<NSNumber *, FeaturesItemModel *> *snapshot = [NSDiffableDataSourceSnapshot<NSNumber *, FeaturesItemModel *> new];
        
        NSNumber *firstSection = @(0);
        [snapshot appendSectionsWithIdentifiers:@[firstSection]];
        
        FeaturesItemModel *contentUnavilableViewItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeContentUnavailableView];
        FeaturesItemModel *shapeItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeShape];
        FeaturesItemModel *uniformAcrossSiblingsItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeUniformAcrossSiblings];
        FeaturesItemModel *pageControlItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypePageControl];
        FeaturesItemModel *labelVibrancyItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeLabelVibrancy];
        FeaturesItemModel *lefferformAwareAdjustingItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeLefferformAwareAdjusting];
        FeaturesItemModel *hdrImageItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeHDRImage];
        FeaturesItemModel *symbolEffectsItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeSymbolEffects];
        FeaturesItemModel *textViewBorderItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeTextViewBorder];
        FeaturesItemModel *viewIsAppearingItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeViewIsAppearing];
        FeaturesItemModel *searchControllerItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeSearchController];
        FeaturesItemModel *textSelectionDisplayItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTextSelectionDisplay];
        FeaturesItemModel *windowSceneDragInteractionItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeWindowSceneDragInteraction];
        FeaturesItemModel *symbolTransitionItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeSymbolTransition];
        FeaturesItemModel *typesettingLanguageItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeTypesettingLanguage];
        FeaturesItemModel *localeImageItemModel = [[FeaturesItemModel alloc] initWithType:FeaturesItemModelTypeLocaleImage];
        
        [snapshot appendItemsWithIdentifiers:@[contentUnavilableViewItemModel, shapeItemModel, uniformAcrossSiblingsItemModel, pageControlItemModel, labelVibrancyItemModel, lefferformAwareAdjustingItemModel, hdrImageItemModel, symbolEffectsItemModel, textViewBorderItemModel, viewIsAppearingItemModel, searchControllerItemModel, textSelectionDisplayItemModel, windowSceneDragInteractionItemModel, symbolTransitionItemModel, typesettingLanguageItemModel, localeImageItemModel] intoSectionWithIdentifier:firstSection];
        
        [contentUnavilableViewItemModel release];
        [shapeItemModel release];
        [uniformAcrossSiblingsItemModel release];
        [pageControlItemModel release];
        [labelVibrancyItemModel release];
        [lefferformAwareAdjustingItemModel release];
        [hdrImageItemModel release];
        [symbolEffectsItemModel release];
        [textViewBorderItemModel release];
        [viewIsAppearingItemModel release];
        [searchControllerItemModel release];
        [textSelectionDisplayItemModel release];
        [windowSceneDragInteractionItemModel release];
        [symbolTransitionItemModel release];
        [typesettingLanguageItemModel release];
        [localeImageItemModel release];
        
        [dataSource applySnapshot:snapshot animatingDifferences:YES completion:completionHandler];
        [snapshot release];
    }];
}

- (void)itemModelFromIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^)(FeaturesItemModel * _Nullable))completionHandler {
    UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> *dataSource = self.dataSource;
    
    [self.queue addOperationWithBlock:^{
        FeaturesItemModel * _Nullable itemModel = [dataSource itemIdentifierForIndexPath:indexPath];
        completionHandler(itemModel);
    }];
}

- (void)setupQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = NSQualityOfServiceUserInitiated;
    self.queue = queue;
    [queue release];
}

@end
