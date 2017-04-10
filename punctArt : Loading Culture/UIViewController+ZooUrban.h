//
//  UIViewController+ZooUrban.h
//  ZooUrban
//
//  Created by Parvan Florian on 05/06/14.
//  Copyright (c) 2014 Adonis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZooUrban)

// use transitions AND / OR animations
- (void)presentChildViewController:(UIViewController *)viewControllerToPresent
							inView:(UIView *)parentView
						animations:(void (^) (UIView *parentView, UIView *childView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^) (BOOL finished))completion;
// default animation
- (void)presentChildViewController:(UIViewController *)viewControllerToPresent
						  animated:(BOOL)animated
						completion:(void (^) (BOOL finished))completion;

// use transitions AND / OR animations
- (void)presentChildViewController:(UIViewController *)viewControllerToPresent
					 replacingView:(UIView *)viewToReplace
						animations:(void (^) (UIView *parentView, UIView *fromChildView, UIView *toChildView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^) (BOOL finished))completion;

// use transitions OR animations
- (void)dismissFromParentWithAnimations:(void (^) (UIView *parentView, UIView *childView))animations
							   duration:(NSTimeInterval)duration
								options:(UIViewAnimationOptions)options
							 completion:(void (^) (BOOL finished))completion;
// default animation
- (void)dismissFromParentAnimated:(BOOL)animated
					   completion:(void (^)(BOOL finished))completion;

// called from parent
- (void)dismissChildViewController:(UIViewController *)viewControllerToDismiss
						animations:(void (^) (UIView *parentView, UIView *childView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^) (BOOL finished))completion;
// default animation
- (void)dismissChildViewController:(UIViewController *)viewControllerToDismiss
						  animated:(BOOL)animated
						completion:(void (^)(BOOL finished))completion;

// use transitions OR animations
- (void)dismissFromParentWithView:(UIView *)viewToShow
					   animations:(void (^) (UIView *parentView, UIView *fromChildView, UIView *toChildView))animations
						 duration:(NSTimeInterval)duration
						  options:(UIViewAnimationOptions)options
					   completion:(void (^) (BOOL finished))completion;

// called from parent
- (void)dismissChildViewController:(UIViewController *)viewControllerToDismiss
						  withView:(UIView *)viewToShow
						animations:(void (^) (UIView *parentView, UIView *fromChildView, UIView *toChildView))animations
						  duration:(NSTimeInterval)duration
						   options:(UIViewAnimationOptions)options
						completion:(void (^) (BOOL finished))completion;

-(void)dismissFromParent;

- (BOOL)isRootViewController;

@end
