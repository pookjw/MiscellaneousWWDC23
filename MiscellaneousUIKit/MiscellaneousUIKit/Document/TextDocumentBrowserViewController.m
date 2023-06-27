//
//  TextDocumentBrowserViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/27/23.
//

#import "TextDocumentBrowserViewController.h"
#import "DocumentViewController.h"
#import "Document.h"
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

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didRequestDocumentCreationWithHandler:(void (^)(NSURL * _Nullable, UIDocumentBrowserImportMode))importHandler {
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSURL *temporaryURL = fileManager.temporaryDirectory;
    NSURL *demoFileURL = [[temporaryURL URLByAppendingPathComponent:@"demo"] URLByAppendingPathExtensionForType:UTTypePlainText];
    
    if ([fileManager fileExistsAtPath:demoFileURL.path isDirectory:nil]) {
        NSError * _Nullable error = nil;
        [fileManager removeItemAtURL:demoFileURL error:&error];
        NSAssert((error == nil), error.localizedDescription);
    }
    
    NSString *text = @"Hello World!";
    [fileManager createFileAtPath:demoFileURL.path contents:[text dataUsingEncoding:NSUTF8StringEncoding] attributes:@{}];
    
    importHandler(demoFileURL, UIDocumentBrowserImportModeMove);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)documentURLs {
    NSURL *documentURL = documentURLs.firstObject;
    NSAssert(documentURL, @"");
    Document *document = [[Document alloc] initWithFileURL:documentURL];
    DocumentViewController *documentViewController = [[DocumentViewController alloc] initWithDocument:document];
    [document release];
    [self.navigationController pushViewController:documentViewController animated:YES];
    [documentViewController release];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller failedToImportDocumentAtURL:(NSURL *)documentURL error:(NSError *)error {
    assert(error);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller willPresentActivityViewController:(UIActivityViewController *)activityViewController {
    
}

- (NSArray<__kindof UIActivity *> *)documentBrowser:(UIDocumentBrowserViewController *)controller applicationActivitiesForDocumentURLs:(NSArray<NSURL *> *)documentURLs {
    return @[];
}

@end
