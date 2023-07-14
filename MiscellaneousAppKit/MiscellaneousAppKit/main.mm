//
//  main.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.hpp"

int main(int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    NSApplication *application = NSApplication.sharedApplication;
    AppDelegate *appDelegate = [AppDelegate new];
    application.delegate = appDelegate;
    [application release];
    [application run];
    
    [pool release];
    
    return EXIT_SUCCESS;
}
