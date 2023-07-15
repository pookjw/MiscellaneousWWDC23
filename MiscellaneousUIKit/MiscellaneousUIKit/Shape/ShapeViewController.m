//
//  ShapeViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import "ShapeViewController.h"
#import <objc/message.h>
#import <dlfcn.h>

OBJC_EXPORT id objc_msgSendSuper2(void);

@interface DemoHoverStyle : NSObject
@property (nonatomic, strong) id<UIHoverEffect> effect;
@property (nonatomic, strong, nullable) UIShape *shape;
+ (DemoHoverStyle *)styleWithEffect:(id<UIHoverEffect>)effect shape:(UIShape *)shape;
@end

@implementation DemoHoverStyle

+ (DemoHoverStyle *)styleWithEffect:(id<UIHoverEffect>)effect shape:(UIShape *)shape {
    DemoHoverStyle *result = [DemoHoverStyle new];
    
    result.effect = effect;
    result.shape = shape;
    return [result autorelease];
}

@end

@interface ShapeViewController ()

@end

@implementation ShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UILabel *label = [UILabel new];
    label.text = @"Test";
    label.backgroundColor = UIColor.systemPurpleColor;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
//    UIHoverAutomaticEffect *effect = [UIHoverAutomaticEffect new];
//    UIShape *shape = [UIShape capsuleShape];
//    
//    DemoHoverStyle *hoverStyle = [DemoHoverStyle styleWithEffect:effect shape:shape];
//    UIHoverStyle *garbage = ((id (*)(id, SEL))objc_msgSend)(UIHoverStyle.class, @selector(new));
//    UIHoverStyle *hoverStyle = ((id (*)(id, SEL, id, id))objc_msgSend)(garbage, @selector(styleWithEffect:shape:), effect, shape);
    
//    Method method = class_getInstanceMethod(UIHoverStyle.class, @selector(styleWithEffect:shape:));
//    IMP imp = method_getImplementation(method);
//    UIHoverStyle *hoverStyle = ((id (*)(Class, SEL, id, id))imp)(UIHoverStyle.class, @selector(styleWithEffect:shape:), effect, shape);
    
//    UIHoverStyle *hoverStyle = [UIHoverStyle styleWithEffect:effect shape:shape];
//    [effect release];
//    label.hoverStyle = hoverStyle;
//    [label release];
}

@end
