//
//  UINavigationController+ATProxy.m
//  ATProxy
//
//  Created by YLCHUN on 2018/7/14.
//  Copyright © 2018年 ylchun. All rights reserved.
//

#import "UINavigationController+ATProxy.h"
#import "_UIViewControllerTransition.h"
#import "_ATProxyIMP.h"

@implementation UINavigationController (atp)

- (void)atp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated];
    
//    return;
//    SEL sel = @selector(pushViewController:animated:);
//    void(*imp)(id, SEL, id, BOOL) = (void(*)(id, SEL, id, BOOL))apt_methodOrignImp([UINavigationController class], sel);
//    if (imp) {
//        imp(self, sel, viewController, animated);
//    }else {
//        [self pushViewController:viewController animated:animated];
//    }
}

- (UIViewController *)atp_popViewControllerAnimated:(BOOL)animated {
    return [self popViewControllerAnimated:animated];
    
//    SEL sel = @selector(popViewControllerAnimated:);
//    id(*imp)(id, SEL, BOOL) = (id(*)(id, SEL, BOOL))apt_methodOrignImp([UINavigationController class], sel);
//    if (imp) {
//        return imp(self, sel, animated);
//    }else {
//        return [self popViewControllerAnimated:animated];
//    }
}

- (NSArray<UIViewController *> *)atp_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self popToViewController:viewController animated:animated];
    
//    SEL sel = @selector(popToViewController:animated:);
//    id(*imp)(id, SEL, id, BOOL) = (id(*)(id, SEL, id, BOOL))apt_methodOrignImp([UINavigationController class], sel);
//    if (imp) {
//        return imp(self, sel, viewController, animated);
//    }else {
//        return [self popToViewController:viewController animated:animated];
//    }
}

- (NSArray<UIViewController *> *)atp_popToRootViewControllerAnimated:(BOOL)animated {
    return [self popToRootViewControllerAnimated:animated];
    
//    SEL sel = @selector(popToRootViewControllerAnimated:);
//    id(*imp)(id, SEL, BOOL) = (id(*)(id, SEL, BOOL))apt_methodOrignImp([UINavigationController class], sel);
//    if (imp) {
//        return imp(self, sel, animated);
//    }else {
//        return [self popToRootViewControllerAnimated:animated];
//    }
}

- (void)atp_setDelegate:(id<UINavigationControllerDelegate>)delegate {
    SEL sel = @selector(setDelegate:);
    void(*imp)(id, SEL, id) = (void(*)(id, SEL, id))apt_methodOrignImp([UINavigationController class], sel);
    if (imp) {
        imp(self, sel, delegate);
    }else {
        [self setDelegate:delegate];
    }
}

@end

@implementation UINavigationController (ATProxy)

- (void)pushViewController:(UIViewController *)viewController transitional:(id<UIViewControllerAnimatedTransitioning>)transitional {
    [self setupTransition:transitional];
    [self atp_pushViewController:viewController animated:transitional != nil];
}

- (UIViewController *)popViewControllerTransitional:(id<UIViewControllerAnimatedTransitioning>)transitional {
    [self setupTransition:transitional];
    return [self atp_popViewControllerAnimated:transitional != nil];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController transitional:(id<UIViewControllerAnimatedTransitioning>)transitional {
    [self setupTransition:transitional];
    return [self atp_popToViewController:viewController animated:transitional != nil];
}

- (NSArray<UIViewController *> *)popToRootViewControllerTtransitional:(id<UIViewControllerAnimatedTransitioning>)transitional {
    [self setupTransition:transitional];
    return [self atp_popToRootViewControllerAnimated:transitional != nil];
}

- (void)setupTransition:(id<UIViewControllerAnimatedTransitioning>)transition {
    if (!transition) return;
    [_UIViewControllerTransition setupTransition:transition delegate:self.delegate reset:^(id delegate) {
        [self atp_setDelegate:delegate];
    }];
}


@end


