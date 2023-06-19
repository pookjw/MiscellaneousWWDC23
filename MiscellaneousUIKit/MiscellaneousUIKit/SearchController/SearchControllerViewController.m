//
//  SearchControllerViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/18/23.
//

#import "SearchControllerViewController.h"
#import "_SearchControllerViewController.h"

@interface SearchControllerViewController () <UISearchResultsUpdating>

@end

@implementation SearchControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    _SearchControllerViewController *searchResultsController = [_SearchControllerViewController new];
    self.contentUnavailableConfiguration = [UIContentUnavailableConfiguration searchConfiguration];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    [searchResultsController release];
    searchController.obscuresBackgroundDuringPresentation = YES;
    searchController.searchResultsUpdater = self;
    
    // ???
    searchController.searchBar.lookToDictateEnabled = YES;
    NSLog(@"%d", searchController.searchBar.lookToDictateEnabled);
    
    self.navigationItem.searchController = searchController;
    [searchController release];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self setNeedsUpdateContentUnavailableConfiguration];
}

- (void)updateContentUnavailableConfigurationUsingState:(UIContentUnavailableConfigurationState *)state {
    [super updateContentUnavailableConfigurationUsingState:state];
    NSLog(@"%@", state.searchText);
}

@end
