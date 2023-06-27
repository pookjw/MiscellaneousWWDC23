//
//  Document.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/28/23.
//

#import "Document.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@implementation Document {
    NSProgress *_progress;
    UIDocumentState _documentState;
}

- (instancetype)initWithFileURL:(NSURL *)url {
    if (self = [super initWithFileURL:url]) {
        _progress = [[NSProgress progressWithTotalUnitCount:10] retain];
        
        _documentState = UIDocumentStateClosed;
    }
    
    return self;
}

- (void)dealloc {
    [_text release];
    [_progress release];
    [super dealloc];
}

- (NSString *)localizedName {
    return self.fileURL.URLByDeletingPathExtension.lastPathComponent;
}

- (NSString *)fileType {
    return UTTypePlainText.identifier;
}

- (NSProgress *)progress {
    return _progress;
}

- (UIDocumentState)documentState {
//    NSLog(@"%lu", [super documentState]);
//    return [super documentState];
    return _documentState;
}

/*
 원래는
 openWithCompletionHandler에서 내부적으로 performAsynchronousFileAccessUsingBlock -> readFromURL 순으로 호출하면서 파일을 불러와서 completionHandler을 호출한다.
 하지만 파일 불러오는 것을 직접 커스텀할 경우 completionHandler를 부르지 않는다. 이 경우 NSProgress 같은 것도 쓸 수 있다.
 */
- (void)openWithCompletionHandler:(void (^)(BOOL))completionHandler {
//    [super openWithCompletionHandler:completionHandler];
    
    _documentState = UIDocumentStateClosed | UIDocumentStateProgressAvailable;
    [NSNotificationCenter.defaultCenter postNotificationName:UIDocumentStateChangedNotification object:self];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSLog(@"%d", self.progress.finished);
        
        while (!self.progress.finished) {
            self.progress.completedUnitCount += 1;
            [NSThread sleepForTimeInterval:0.2f];
            NSLog(@"%lld", self.progress.completedUnitCount);
        }
        
        NSString *text = [[NSString alloc] initWithContentsOfURL:self.fileURL encoding:NSUTF8StringEncoding error:nil];
        self.text = text;
        [text release];
        
        _documentState = UIDocumentStateNormal;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [NSNotificationCenter.defaultCenter postNotificationName:UIDocumentStateChangedNotification object:self];
            completionHandler(YES);
        });
    });
}

- (void)performAsynchronousFileAccessUsingBlock:(void (^)(void))block {
    [super performAsynchronousFileAccessUsingBlock:block];
}

- (BOOL)readFromURL:(NSURL *)url error:(NSError * _Nullable *)outError {
    return [super readFromURL:url error:outError];
}
//
//- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable *)outError {
//    NSAssert([contents isKindOfClass:NSData.class], @"");
//    NSString *text = [[NSString alloc] initWithData:contents encoding:NSUTF8StringEncoding];
//    self.text = text;
//    [text release];
//    
//    return YES;
//}

@end
