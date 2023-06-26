//
//  DocumentViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/27/23.
//

#import "DocumentViewController.h"
#import "SymbolButtonConfiguration.h"
#import "TextDocumentBrowserViewController.h"

@interface DocumentViewController ()

@end

@implementation DocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    SymbolButtonConfiguration *configuration = [SymbolButtonConfiguration plainButtonConfiguration];
    SymbolButtonConfigurationEffect *effect = [[SymbolButtonConfigurationEffect alloc] initWithSymbolEffect:[NSSymbolBounceEffect bounceDownEffect]
                                                                                                    options:[NSSymbolEffectOptions optionsWithRepeating]
                                                                                                   animated:YES
                                                                                                 completion:nil];
    [configuration.sbc_effects addObject:effect];
    [effect release];
    configuration.image = [UIImage systemImageNamed:@"hands.clap.fill"];
    
    UIButton *button = [UIButton buttonWithConfiguration:configuration primaryAction:nil];
    [button addTarget:self action:@selector(foo:) forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)foo:(UIButton *)sender {
    TextDocumentBrowserViewController *browserViewController = [TextDocumentBrowserViewController new];
    [self.navigationController pushViewController:browserViewController animated:YES];
    [browserViewController release];
}

@end
