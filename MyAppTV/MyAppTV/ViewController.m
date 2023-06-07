//
//  ViewController.m
//  MyAppTV
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate>
@property (strong) UICollectionView *collectionView;
@property (strong) UICollectionViewDiffableDataSource<NSNumber *, NSString *> *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    self.dataSource = [self createDataSource];
    
    NSDiffableDataSourceSnapshot *snapshot = [NSDiffableDataSourceSnapshot new];
    [snapshot appendSectionsWithIdentifiers:@[@0]];
    [snapshot appendItemsWithIdentifiers:@[@"1", @"2", @"3"] intoSectionWithIdentifier:@0];
    [self.dataSource applySnapshotUsingReloadData:snapshot];
}

- (void)setupCollectionView {
    UICollectionLayoutListConfiguration *configuration = [[UICollectionLayoutListConfiguration alloc] initWithAppearance:UICollectionLayoutListAppearanceGrouped];
    UICollectionViewCompositionalLayout *layout = [UICollectionViewCompositionalLayout layoutWithListConfiguration:configuration];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (UICollectionViewDiffableDataSource<NSNumber *, NSString *> *)createDataSource {
    UICollectionViewCellRegistration *cellRegistration = [self createCellRegistration];
    
    UICollectionViewDiffableDataSource<NSNumber *,NSString *> *dataSource = [[UICollectionViewDiffableDataSource<NSNumber *, NSString *> alloc] initWithCollectionView:self.collectionView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        UICollectionViewListCell *cell = [collectionView dequeueConfiguredReusableCellWithRegistration:cellRegistration forIndexPath:indexPath item:itemIdentifier];
        return cell;
    }];
    
    return dataSource;
}

- (UICollectionViewCellRegistration *)createCellRegistration {
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:UICollectionViewListCell.class configurationHandler:^(__kindof UICollectionViewListCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, NSString * _Nonnull item) {
        UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
        contentConfiguration.text = item;
        cell.contentConfiguration = contentConfiguration;
    }];
    
    return cellRegistration;
}

- (UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths point:(CGPoint)point {
    UIContextMenuConfiguration *configuration = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        NSMutableArray *children = [suggestedActions mutableCopy];
        
        UIAction *first = [UIAction actionWithTitle:@"First" image:[UIImage systemImageNamed:@"heart"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
        }];
        
        first.attributes = UIMenuElementAttributesKeepsMenuPresented;
        
        UIAction *second = [UIAction actionWithTitle:@"Second" image:[UIImage systemImageNamed:@"heart.fill"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
        }];
        
        [children addObject:first];
        [children addObject:second];
        
        UIMenu *menu = [UIMenu menuWithTitle:@"Menu" image:[UIImage systemImageNamed:@"heart"] identifier:nil options:0 children:children];
        return menu;
    }];
    
    return configuration;
}

@end
