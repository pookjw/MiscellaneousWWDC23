//
//  SceneDelegate.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "SceneDelegate.h"
#import "FeaturesViewController.h"
#import "UIViewController+Category.h"
#import <WebKit/WebKit.h>

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    FeaturesViewController *featuresViewController = [FeaturesViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:featuresViewController];
    [featuresViewController release];
    
    window.rootViewController = navigationController;
    [navigationController release];
    
    [window makeKeyAndVisible];
    self.window = window;
    [window release];
    
    [self presentWebViewControllerWithURLContexts:connectionOptions.URLContexts];
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    [self presentWebViewControllerWithURLContexts:URLContexts];
}

- (void)presentWebViewControllerWithURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    [URLContexts enumerateObjectsUsingBlock:^(UIOpenURLContext * _Nonnull obj, BOOL * _Nonnull stop) {
        UIViewController *webViewController = [UIViewController new];
        WKWebView *webView = [WKWebView new];
        
//        NSDictionary *dictionary = [NSDictionary d]
        NSLog(@"%@", obj.options.annotation);
        NSString *path = [[NSString alloc] initWithContentsOfURL:obj.URL encoding:NSUTF8StringEncoding error:nil];
        NSURL *url = [[NSURL alloc] initWithString:path];
        [path release];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [url release];
        [webView loadRequest:request];
        [request release];
        webView.translatesAutoresizingMaskIntoConstraints = NO;
        [webViewController.view addSubview:webView];
        [NSLayoutConstraint activateConstraints:@[
            [webView.topAnchor constraintEqualToAnchor:webViewController.view.topAnchor],
            [webView.leadingAnchor constraintEqualToAnchor:webViewController.view.leadingAnchor],
            [webView.trailingAnchor constraintEqualToAnchor:webViewController.view.trailingAnchor],
            [webView.bottomAnchor constraintEqualToAnchor:webViewController.view.bottomAnchor]
        ]];
        [webView release];
        
        [self.window.rootViewController.mostPresentedViewController presentViewController:webViewController animated:YES completion:^{
            
        }];
        [webViewController release];
    }];
}

@end
