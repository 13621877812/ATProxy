//
//  UIViewController+ATProxy.m
//  ATProxy
//
//  Created by YLCHUN on 2018/8/3.
//  Copyright © 2018年 ylchun. All rights reserved.
//

#import "UIViewController+ATProxy.h"
#import "ATAnimatedTransitioningDelegateProxy.h"
#import "ATMethodIMP.h"

@implementation UIViewController (atp)

- (void)atp_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (kATOriginal) {
        SEL sel = @selector(presentViewController:animated:completion:);
        void(*imp)(id, SEL, id, BOOL, id) = (void(*)(id, SEL, id, BOOL, id))atp_methodOrignImp([UIViewController class], sel);
        if (imp) {
            imp(self, sel, viewControllerToPresent, flag, completion);
        }else {
            [self presentViewController:viewControllerToPresent animated:flag completion:completion];
        }
    }else {
        [self presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}

- (void)atp_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if (kATOriginal) {
        SEL sel = @selector(dismissViewControllerAnimated:completion:);
        void(*imp)(id, SEL, BOOL, id) = (void(*)(id, SEL, BOOL, id))atp_methodOrignImp([UIViewController class], sel);
        if (imp) {
            imp(self, sel, flag, completion);
        }else {
            [self dismissViewControllerAnimated:flag completion:completion];
        }
    }else {
        [self dismissViewControllerAnimated:flag completion:completion];
    }
}

- (void)atp_setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)delegate {
    SEL sel = @selector(setTransitioningDelegate:);
    void(*imp)(id, SEL, id) = (void(*)(id, SEL, id))atp_methodOrignImp([UIViewController class], sel);
    if (imp) {
        imp(self, sel, delegate);
    }else {
        [self setTransitioningDelegate:delegate];
    }
}

@end

@implementation UIViewController (ATProxy)

- (void)presentViewController:(UIViewController *)viewControllerToPresent transitional:(id<UIViewControllerAnimatedTransitioning>)transitional completion:(void(^)(void))completion {
    [viewControllerToPresent setupTransition:transitional];
    [self atp_presentViewController:viewControllerToPresent animated:transitional != nil completion:completion];
}

- (void)dismissViewControllerTtransitional:(id<UIViewControllerAnimatedTransitioning>)transitional completion:(void (^)(void))completion {
    [self setupTransition:transitional];
    [self atp_dismissViewControllerAnimated:transitional != nil completion:completion];
}

- (void)setupTransition:(id<UIViewControllerAnimatedTransitioning>)transition {
    if (!transition) return;
    [ATAnimatedTransitioningDelegateProxy setupTransition:transition delegate:self.transitioningDelegate reset:^(id delegate) {
        [self atp_setTransitioningDelegate:delegate];
    }];
}

@end

