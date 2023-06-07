//
//  UniformAcrossSiblingsViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import "UniformAcrossSiblingsViewController.h"
#import "UniformAcrossSiblingsContentConfiguration.h"

@interface UniformAcrossSiblingsViewController ()
@property (retain) UICollectionView *collectionView;
@property (retain) UICollectionViewDiffableDataSource<NSNumber *, NSString *> *dataSource;
@end

@implementation UniformAcrossSiblingsViewController

- (void)dealloc {
    [_collectionView release];
    [_dataSource release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    
    self.dataSource = [self createDataSource];
    NSDiffableDataSourceSnapshot *snapshot = [NSDiffableDataSourceSnapshot new];
    [snapshot appendSectionsWithIdentifiers:@[@0]];
    [snapshot appendItemsWithIdentifiers:@[@"3", @"4"] intoSectionWithIdentifier:@0];
    [self.dataSource applySnapshotUsingReloadData:snapshot];
    [snapshot release];
}

- (void)setupCollectionView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self createLayout]];
    
    collectionView.backgroundColor = UIColor.systemBackgroundColor;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView release];
}

- (UICollectionViewCompositionalLayout *)createLayout {
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger sectionIndex, id<NSCollectionLayoutEnvironment>  _Nonnull layoutEnvironment) {
        
        NSUInteger itemCount = 2;
        NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.f / itemCount]
                                                                          heightDimension:[NSCollectionLayoutDimension uniformAcrossSiblingsWithEstimate:100.f]];
        
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
        
        NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.f]
                                                                           heightDimension:[NSCollectionLayoutDimension estimatedDimension:100.f]];
        
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize repeatingSubitem:item count:itemCount];
        
        return [NSCollectionLayoutSection sectionWithGroup:group];
    }];
    
    return [layout autorelease];
}

- (UICollectionViewDiffableDataSource<NSNumber *, NSString *> *)createDataSource {
    UICollectionViewCellRegistration *cellRegistration = [self createCellRegistration];
    
    UICollectionViewDiffableDataSource<NSNumber *,NSString *> *dataSource = [[UICollectionViewDiffableDataSource<NSNumber *, NSString *> alloc] initWithCollectionView:self.collectionView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        UICollectionViewListCell *cell = [collectionView dequeueConfiguredReusableCellWithRegistration:cellRegistration forIndexPath:indexPath item:itemIdentifier];
        return cell;
    }];
    
    return [dataSource autorelease];
}

- (UICollectionViewCellRegistration *)createCellRegistration {
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:UICollectionViewListCell.class configurationHandler:^(__kindof UICollectionViewListCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, NSString * _Nonnull item) {
        UniformAcrossSiblingsContentConfiguration *contentConfiguration = [[UniformAcrossSiblingsContentConfiguration alloc] initWithImageName:item];
        cell.contentConfiguration = contentConfiguration;
        [contentConfiguration release];
    }];
    
    return cellRegistration;
}

@end
