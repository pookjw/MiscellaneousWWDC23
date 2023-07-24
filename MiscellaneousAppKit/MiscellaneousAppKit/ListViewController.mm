//
//  ListViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import "ListViewController.hpp"
#import "ListTableCellView.hpp"
#import <vector>
#import "NSApplicationViewController.hpp"
#import "DisplayLinkViewController.hpp"
#import "TextViewController.hpp"
#import "ButtonsViewController.hpp"
#import "ColorWellViewController.hpp"
#import "ProcessIndicatorViewController.hpp"
#import "PresentViewController.hpp"
#import "MenuViewController.hpp"

static NSUserInterfaceItemIdentifier const NSUserInterfaceItemIdentifierClassNameTableColumn = @"NSUserInterfaceItemIdentifierClassNameTableColumn";
static NSUserInterfaceItemIdentifier const NSUserInterfaceItemIdentifierListTableCellView = @"NSUserInterfaceItemIdentifierListTableCellView";

@interface ListViewController () <NSOutlineViewDataSource, NSOutlineViewDelegate>
@property (retain) NSScrollView *scrollView;
@property (retain) NSOutlineView *outlineView;
@property (assign) std::vector<Class> classes;
@end

@implementation ListViewController

- (void)dealloc {
    [_scrollView release];
    [_outlineView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    const std::vector<Class> classes {
        NSApplicationViewController.class,
        DisplayLinkViewController.class,
        TextViewController.class,
        ButtonsViewController.class,
        ColorWellViewController.class,
        ProcessIndicatorViewController.class,
        PresentViewController.class,
        MenuViewController.class
    };
    self.classes = classes;
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.view addSubview:scrollView];
    
    NSOutlineView *outlineView = [NSOutlineView new];
    outlineView.dataSource = self;
    outlineView.delegate = self;
    
    NSTableColumn *tableColumn = [[NSTableColumn alloc] initWithIdentifier:NSUserInterfaceItemIdentifierClassNameTableColumn];
    tableColumn.title = @"Classes";
    [outlineView addTableColumn:tableColumn];
    [tableColumn release];
    
    NSNib *cellViewNib = [[NSNib alloc] initWithNibNamed:NSStringFromClass(ListTableCellView.class) bundle:[NSBundle bundleForClass:ListTableCellView.class]];
    [outlineView registerNib:cellViewNib forIdentifier:NSUserInterfaceItemIdentifierListTableCellView];
    [cellViewNib release];
    
    scrollView.documentView = outlineView;
    
    self.scrollView = scrollView;
    self.outlineView = outlineView;
    [scrollView release];
    [outlineView release];
}

#pragma mark - NSOutlineViewDataSource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return self.classes.size();
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return self.classes.at(index);
}

#pragma mark - NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    ListTableCellView *view = [outlineView makeViewWithIdentifier:NSUserInterfaceItemIdentifierListTableCellView owner:nullptr];
    view.textField.stringValue = NSStringFromClass(item);
    return view;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView userCanChangeVisibilityOfTableColumn:(NSTableColumn *)column {
    return YES;
}

- (void)outlineView:(NSOutlineView *)outlineView userDidChangeVisibilityOfTableColumns:(NSArray<NSTableColumn *> *)columns {
    
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    if ([self.outlineView isEqual:notification.object]) {
        Class selectedClass = self.classes.at(self.outlineView.selectedRow);
        [NSNotificationCenter.defaultCenter postNotificationName:NSNotificationNameListViewControllerDidSelectClass
                                                          object:self
                                                        userInfo:@{ListViewControllerDidSelectClassKey: selectedClass}];
    }
}

@end
