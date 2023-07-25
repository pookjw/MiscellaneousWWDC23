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
#import "LabelVibrancyViewController.h"
#import "LefferformAwareAdjustingViewController.h"
#import "HDRImageViewController.h"
#import "SymbolEffectsViewController.h"
#import "TextViewBorderViewController.h"
#import "ViewIsAppearingViewController.h"
#import "SearchControllerViewController.h"
#import "TextSelectionDisplayViewController.h"
#import "WindowSceneDragInteractionViewController.h"
#import "SymbolTransitionViewController.h"
#import "TypesettingLanguageViewController.h"
#import "LocaleImageViewController.h"
#import "DocumentRootViewController.h"
#import "SpringDurationViewController.h"
#import "ActivateSceneSessionViewController.h"
#import "MenuViewController.h"

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
            case FeaturesItemModelTypeLabelVibrancy: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"LabelVibrancy";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeLefferformAwareAdjusting: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"LefferformAwareAdjusting";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeHDRImage: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"HDRImage";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeSymbolEffects: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"Symbol Effects";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeTextViewBorder: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"TextView Border";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeViewIsAppearing: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"viewIsAppearing";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeSearchController: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"Search Controller";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTextSelectionDisplay: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"Text Selection Display";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeWindowSceneDragInteraction: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"UIWindowSceneDragInteraction";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeSymbolTransition: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"SymbolTransition";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeTypesettingLanguage: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"TypesettingLanguage";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeLocaleImage: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"LocaleImage";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeDocument: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"Document";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeSpringDuration: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"SpringDuration";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeActivateSceneSession: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"ActivateSceneSession";
                cell.contentConfiguration = contentConfiguration;
                break;
            }
            case FeaturesItemModelTypeMenu: {
                UICellAccessoryOutlineDisclosure *outlineDisclosure = [UICellAccessoryOutlineDisclosure new];
                
                cell.accessories = @[
                    outlineDisclosure
                ];
                
                [outlineDisclosure release];
                
                UIListContentConfiguration *contentConfiguration = [UIListContentConfiguration cellConfiguration];
                contentConfiguration.text = @"Menu";
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
            case FeaturesItemModelTypeLabelVibrancy:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    LabelVibrancyViewController *viewController = [LabelVibrancyViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            case FeaturesItemModelTypeLefferformAwareAdjusting:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    LefferformAwareAdjustingViewController *viewController = [LefferformAwareAdjustingViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            case FeaturesItemModelTypeHDRImage:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    HDRImageViewController *viewController = [HDRImageViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            case FeaturesItemModelTypeSymbolEffects:
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    SymbolEffectsViewController *viewController = [SymbolEffectsViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            case FeaturesItemModelTypeTextViewBorder: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    TextViewBorderViewController *viewController = [TextViewBorderViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeViewIsAppearing: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    ViewIsAppearingViewController *viewController = [ViewIsAppearingViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeSearchController: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    SearchControllerViewController *viewController = [SearchControllerViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTextSelectionDisplay: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    TextSelectionDisplayViewController *viewController = [TextSelectionDisplayViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeWindowSceneDragInteraction: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    WindowSceneDragInteractionViewController *viewController = [WindowSceneDragInteractionViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeSymbolTransition: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    SymbolTransitionViewController *viewController = [SymbolTransitionViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeTypesettingLanguage: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    TypesettingLanguageViewController *viewController = [TypesettingLanguageViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeLocaleImage: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    LocaleImageViewController *viewController = [LocaleImageViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeDocument: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    DocumentRootViewController *viewController = [DocumentRootViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeSpringDuration: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    SpringDurationViewController *viewController = [SpringDurationViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeActivateSceneSession: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    ActivateSceneSessionViewController *viewController = [ActivateSceneSessionViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            case FeaturesItemModelTypeMenu: {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    MenuViewController *viewController = [MenuViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    [viewController release];
                }];
                break;
            }
            default:
                break;
        }
    }];
}

@end
