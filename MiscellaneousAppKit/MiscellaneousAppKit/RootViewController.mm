//
//  RootViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import "RootViewController.hpp"
#import "RootSplitView.hpp"
#import "ListViewController.hpp"
#import "EmptyViewController.hpp"
#import "InspectorViewController.hpp"

@interface RootViewController ()
@property (readonly, nonatomic) RootSplitView *rootSplitView;
@property (retain) NSSplitViewController *splitViewController;
@property (retain) ListViewController *listViewController;
@property (retain) EmptyViewController *emptyViewController;
@property (retain) InspectorViewController *inspectorViewController;
@end

@implementation RootViewController

- (void)dealloc {
    [_splitViewController release];
    [_listViewController release];
    [_emptyViewController release];
    [_inspectorViewController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSplitViewController *splitViewController = [NSSplitViewController new];
    
    RootSplitView *rootSplitView = [RootSplitView new];
    splitViewController.splitView = rootSplitView;
    [rootSplitView release];
    
    ListViewController *listViewController = [ListViewController new];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(listViewDidSelectClass:)
                                               name:NSNotificationNameListViewControllerDidSelectClass
                                             object:listViewController];
    NSSplitViewItem *listItem = [NSSplitViewItem sidebarWithViewController:listViewController];
    [listViewController release];
    listItem.canCollapse = NO;
    listItem.titlebarSeparatorStyle = NSTitlebarSeparatorStyleShadow;
    [splitViewController addSplitViewItem:listItem];
    
    EmptyViewController *emptyViewController = [EmptyViewController new];
    NSSplitViewItem *emptyItem = [NSSplitViewItem contentListWithViewController:emptyViewController];
    [emptyViewController release];
    emptyItem.titlebarSeparatorStyle = NSTitlebarSeparatorStyleShadow;
    [splitViewController addSplitViewItem:emptyItem];
    
    InspectorViewController *inspectorViewController = [InspectorViewController new];
    NSSplitViewItem *inspectorItem = [NSSplitViewItem inspectorWithViewController:inspectorViewController];
    [inspectorViewController release];
    inspectorItem.springLoaded = YES;
    inspectorItem.titlebarSeparatorStyle = NSTitlebarSeparatorStyleNone;
    [splitViewController addSplitViewItem:inspectorItem];
    
    splitViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:splitViewController];
    [self.view addSubview:splitViewController.view];
    [NSLayoutConstraint activateConstraints:@[
        [splitViewController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [splitViewController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [splitViewController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [splitViewController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    self.splitViewController = splitViewController;
    [splitViewController release];
}

- (void)listViewDidSelectClass:(NSNotification *)notification {
    Class selectedClass = notification.userInfo[ListViewControllerDidSelectClassKey];
    
    [NSOperationQueue.mainQueue addOperationWithBlock:^{
        __kindof NSViewController *viewController = [selectedClass new];
        NSSplitViewItem *item = [NSSplitViewItem contentListWithViewController:viewController];
        [viewController release];
        
        [self.splitViewController removeSplitViewItem:self.splitViewController.splitViewItems[1]];
        [self.splitViewController insertSplitViewItem:item atIndex:1];
    }];
}

@end
