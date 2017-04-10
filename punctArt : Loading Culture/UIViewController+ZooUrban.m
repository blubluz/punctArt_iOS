//
//  UIViewController+ZooUrban.m
//  ZooUrban
//
//  Created by Parvan Florian on 05/06/14.
//  Copyright (c) 2014 Adonis Software. All rights reserved.
//

#import "UIViewController+ZooUrban.h"

@implementation UIViewController (ZooUrban)

- (void)presentChildViewController:(UIViewController *)viewControllerToPresent
							inView:(UIView *)parentView
						animations:(void (^)(UIView *parentView, UIView *childView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^)(BOOL finished))completion
{
	if (viewControllerToPresent.parentViewController == self) {
		return;
	}
    
	[viewControllerToPresent.view layoutIfNeeded];
    
	if (parentView == nil) {
		parentView = self.view;
	}
    
	UIView *childView = viewControllerToPresent.view;
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    
	if (!animations) {
		[childView setFrame:parentView.bounds];
	}
    
	[viewControllerToPresent willMoveToParentViewController:self];
	[self addChildViewController:viewControllerToPresent];
    
	[UIView transitionWithView:parentView
					  duration:duration
					   options:options | UIViewAnimationOptionAllowAnimatedContent
					animations:^{
                        [parentView addSubview:childView];
                        
                        [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[v]"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:@{@"v":childView}]];

                        [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v]-(0)-|"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:@{@"v":childView}]];

                        [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[v]"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:@{@"v":childView}]];

                        [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[v]-(0)-|"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:@{@"v":childView}]];
                        
                        if (animations) {
                            animations(parentView, childView);
                        }
                    } completion:^(BOOL finished) {
                        [viewControllerToPresent didMoveToParentViewController:self];
                        
                        if (completion) {
                            completion(finished);
                        }
                    }];
}

- (void)presentChildViewController:(UIViewController *)viewControllerToPresent
						  animated:(BOOL)animated
						completion:(void (^) (BOOL finished))completion
{
	if (animated) {
		viewControllerToPresent.view.alpha = 0.0;
		[self presentChildViewController:viewControllerToPresent inView:self.view animations:^(UIView *parentView, UIView *childView) {
            childView.alpha = 1.0;
        } duration:0.15 options:UIViewAnimationOptionCurveEaseIn completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
	}
	else {
		[self presentChildViewController:viewControllerToPresent inView:self.view animations:nil duration:0 options:0 completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
	}
}

- (void)presentChildViewController:(UIViewController *)viewControllerToPresent
					 replacingView:(UIView *)viewToReplace
						animations:(void (^)(UIView *parentView, UIView *fromChildView, UIView *toChildView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^)(BOOL finished))completion
{
	UIView *parentView  = self.view;
	UIView *toChildView = viewControllerToPresent.view;
    
	[toChildView layoutIfNeeded];
    
	if (viewToReplace && viewToReplace != self.view) {
		
        
		[viewControllerToPresent willMoveToParentViewController:self];
		[self addChildViewController:viewControllerToPresent];
        
		[UIView transitionWithView:parentView
						  duration:duration
						   options:options | UIViewAnimationOptionAllowAnimatedContent
						animations:^{
                            [parentView addSubview:toChildView];
                            
                            [toChildView setFrame:viewToReplace.frame];
                            

                            
                            if (animations) {
                                animations(parentView, viewToReplace, toChildView);
                            }
                            
                            [viewToReplace removeFromSuperview];
                        } completion:^(BOOL finished) {
                            [viewControllerToPresent didMoveToParentViewController:self];
                            
                            if (completion) {
                                completion(finished);
                            }
                        }];
	}
}

- (void)dismissFromParentWithAnimations:(void (^)(UIView *parentView, UIView *childView))animations
							   duration:(NSTimeInterval)duration
								options:(UIViewAnimationOptions)options
							 completion:(void (^)(BOOL finished))completion
{    
	UIView *parentView = self.view.superview;
	UIView *childView  = self.view;
    
	[self willMoveToParentViewController:nil];
    
	[UIView transitionWithView:self.view.superview
					  duration:duration
					   options:options | UIViewAnimationOptionAllowAnimatedContent
					animations:^{
                        if (animations) {
                            animations(parentView, childView);
                        }
                        else {
                            [self.view removeFromSuperview];
                        }
                    } completion:^(BOOL finished) {
                        if (animations) {
                            [self.view removeFromSuperview];
                        }
                        
                        [self removeFromParentViewController];
                        [self didMoveToParentViewController:nil];
                        
                        if (completion) {
                            completion(finished);
                        }
                    }];
}

-(void)dismissFromParent{
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [self didMoveToParentViewController:nil];

    
}

- (void)dismissFromParentAnimated:(BOOL)animated
					   completion:(void (^)(BOOL finished))completion
{
	if (animated) {
		[self dismissFromParentWithAnimations:^(UIView *parentView, UIView *childView) {
            childView.alpha = 0.0;
        } duration:0.15 options:UIViewAnimationOptionCurveEaseOut completion:^(BOOL finished) {
            self.view.alpha = 1.0;
        }];
	}
	else {
		[self dismissFromParentWithAnimations:nil duration:0 options:0 completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
	}
}

- (void)dismissChildViewController:(UIViewController *)viewControllerToDismiss
						animations:(void (^) (UIView *parentView, UIView *childView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^) (BOOL finished))completion
{
	[viewControllerToDismiss dismissFromParentWithAnimations:animations duration:duration options:options completion:completion];
}

// default animation
- (void)dismissChildViewController:(UIViewController *)viewControllerToDismiss
						  animated:(BOOL)animated
						completion:(void (^)(BOOL finished))completion
{
	[viewControllerToDismiss dismissFromParentAnimated:animated completion:completion];
}

- (void)dismissFromParentWithView:(UIView *)viewToShow
					   animations:(void (^)(UIView *parentView, UIView *fromChildView, UIView *toChildView))animations
						 duration:(NSTimeInterval)duration
						  options:(UIViewAnimationOptions)options
					   completion:(void (^)(BOOL finished))completion
{
	UIView *parentView = self.view.superview;
	UIView *fromView   = self.view;
    
	[self willMoveToParentViewController:nil];
    
	[UIView transitionWithView:parentView
					  duration:duration
					   options:options | UIViewAnimationOptionAllowAnimatedContent
					animations:^{
                        [parentView addSubview:viewToShow];
                        
                        if (animations) {
                            animations(parentView, fromView, viewToShow);
                        }
                        else {
                            [fromView removeFromSuperview];
                        }
                    } completion:^(BOOL finished) {
                        if (animations) {
                            [fromView removeFromSuperview];
                        }
                        
                        [self removeFromParentViewController];
                        [self didMoveToParentViewController:nil];
                        
                        if (completion) {
                            completion(finished);
                        }
                    }];
}

- (void)dismissChildViewController:(UIViewController *)viewControllerToDismiss
						  withView:(UIView *)viewToShow
						animations:(void (^)(UIView *parentView, UIView *fromChildView, UIView *toChildView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^) (BOOL finished))completion
{
	[viewControllerToDismiss dismissFromParentWithView:viewToShow animations:animations duration:duration options:options completion:completion];
}

- (BOOL)isRootViewController
{
	return self.navigationController.viewControllers[0] == self;
}

@end
