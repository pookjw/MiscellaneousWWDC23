//
//  ViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "FeaturesViewController.h"
#import "FeaturesViewModel.h"
#import "ContentUnavailableViewController.h"
#import "ShapeViewController.h"
#import "UniformAcrossSiblingsViewController.h"
#import "PageControlViewController.h"

@interface FeaturesViewController () <UICollectionViewDelegate>
@property (retain) UICollectionView *collectionView;
@property (retain) FeaturesViewModel *viewModel;
@end

@implementation FeaturesViewController

- (void)dealloc {
    [_collectionView release];
    [_viewModel release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self setupCollectionView];
    [self setupViewModel];
    [self.viewModel loadDataSourceWithCompletionHandler:^{
        
    }];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello tvOS!" message:@"Swizzling!" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"DONE" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [alert addAction:doneAction];
//    [alert addAction:cancelAction];
//    
//    [self presentViewController:alert animated:YES completion:^{
//        
//    }];
//}

- (void)setupCollectionView {
    UICollectionLayoutListConfiguration *configuration = [[UICollectionLayoutListConfiguration alloc] initWithAppearance:UICollectionLayoutListAppearanceInsetGrouped];
    UICollectionViewCompositionalLayout *layout = [UICollectionViewCompositionalLayout layoutWithListConfiguration:configuration];
    [configuration release];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.backgroundColor = UIColor.systemBackgroundColor;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView release];
}

- (void)setupViewModel {
    FeaturesViewModel *viewModel = [[FeaturesViewModel alloc] initWithDataSource:[self createDataSource]];
    self.viewModel = viewModel;
    [viewModel release];
}

- (UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> *)createDataSource {
    UICollectionViewCellRegistration *cellRegistration = [self createCellRegistration];
    
    UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> *dataSource = [[UICollectionViewDiffableDataSource<NSNumber *,FeaturesItemModel *> alloc] initWithCollectionView:self.collectionView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        UICollectionViewListCell *cell = [collectionView dequeueConfiguredReusableCellWithRegistration:cellRegistration forIndexPath:indexPath item:itemIdentifier];
        return cell;
    }];
    
    return [dataSource autorelease];
}

- (UICollectionViewCellRegistration *)createCellRegistration {
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:UICollectionViewListCell.class configurationHandler:^(__kindof UICollectionViewListCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, FeaturesItemModel * _Nonnull item) {
        switch (item.type) {
            case FeaturesItemModelTypeContentUnavailableView: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                // emptyProminentConfiguration, emptyExtraProminentConfiguration
                UIContentUnavailableConfiguration *configuration = [UIContentUnavailableConfiguration searchConfiguration];
                configuration.alignment = UIContentUnavailableAlignmentCenter;
                
                UIBackgroundConfiguration *backgroud = [UIBackgroundConfiguration clearConfiguration];
                backgroud.backgroundColor = UIColor.systemPurpleColor;
                configuration.background = backgroud;
                
                UIButtonConfiguration *button = [UIButtonConfiguration tintedButtonConfiguration];
                button.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
                button.title = @"Button!";
                configuration.button = button;
                
                cell.contentConfiguration = configuration;
                break;
            }
            case FeaturesItemModelTypeShape: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"UIShape";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeUniformAcrossSiblings: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"UniformAcrossSiblings";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypePageControl: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"PageControl";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            default:
                break;
        }
    }];
    
    return cellRegistration;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel itemModelFromIndexPath:indexPath completionHandler:^(FeaturesItemModel * _Nullable itemModel) {
        switch (itemModel.type) {
            case FeaturesItemModelTypeContentUnavailableView: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    ContentUnavailableViewController *viewController = [ContentUnavailableViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeShape:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    ShapeViewController *viewController = [ShapeViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            case FeaturesItemModelTypeUniformAcrossSiblings:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    UniformAcrossSiblingsViewController *viewController = [UniformAcrossSiblingsViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            case FeaturesItemModelTypePageControl:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    PageControlViewController *viewController = [PageControlViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            default:
                break;
        }
    }];
}

@end
