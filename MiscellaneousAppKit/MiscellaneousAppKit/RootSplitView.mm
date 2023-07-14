//
//  RootSplitView.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import "RootSplitView.hpp"

@implementation RootSplitView

- (instancetype)init {
    if (self = [super init]) {
        self.dividerStyle = NSSplitViewDividerStylePaneSplitter;
        self.vertical = YES;
    }
    
    return self;
}

- (CGFloat)dividerThickness {
    return 0.f;
}

- (CGFloat)minPossiblePositionOfDividerAtIndex:(NSInteger)dividerIndex {
    if (dividerIndex == 0) {
        return 300.f;
    } else {
        return [super minPossiblePositionOfDividerAtIndex:dividerIndex];
    }
}

- (CGFloat)maxPossiblePositionOfDividerAtIndex:(NSInteger)dividerIndex {
    if (dividerIndex == 0) {
        return 400.f;
    } else {
        return [super maxPossiblePositionOfDividerAtIndex:dividerIndex];
    }
}

@end
