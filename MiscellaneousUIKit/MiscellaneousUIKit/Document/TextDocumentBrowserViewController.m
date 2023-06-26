//
//  TextDocumentBrowserViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/27/23.
//

#import "TextDocumentBrowserViewController.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@interface TextDocumentBrowserViewController () <UIDocumentBrowserViewControllerDelegate>

@end

// https://developer.apple.com/documentation/uikit/view_controllers/building_a_document_browser-based_app

@implementation TextDocumentBrowserViewController

- (instancetype)init {
    if (self = [self initForOpeningContentTypes:@[UTTypePlainText]]) {
        self.delegate = self;
        self.allowsDocumentCreation = YES;
        self.allowsPickingMultipleItems = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didRequestDocumentCreationWithHandler:(void (^)(NSURL * _Nullable, UIDocumentBrowserImportMode))importHandler {
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSURL *temporaryURL = fileManager.temporaryDirectory;
    NSURL *demoFileURL = [[temporaryURL URLByAppendingPathComponent:@"demo"] URLByAppendingPathExtensionForType:UTTypePlainText];
    
    if ([fileManager fileExistsAtPath:demoFileURL.path isDirectory:nil]) {
        NSError * _Nullable error = nil;
        [fileManager removeItemAtURL:demoFileURL error:&error];
        NSAssert((error == nil), error.localizedDescription);
    }
    
    [fileManager createFileAtPath:demoFileURL.path contents:nil attributes:@{}];
    
    importHandler(demoFileURL, UIDocumentBrowserImportModeMove);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentURLs:(NSArray<NSURL *> *)documentURLs {
    NSLog(@"TODO");
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didImportDocumentAtURL:(NSURL *)sourceURL toDestinationURL:(NSURL *)destinationURL {
    NSLog(@"%@ %@", sourceURL, destinationURL);
    UIDocument *document = [[UIDocument alloc] initWithFileURL:destinationURL];
    
    [document release];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller failedToImportDocumentAtURL:(NSURL *)documentURL error:(NSError *)error {
    assert(error);
}

@end
