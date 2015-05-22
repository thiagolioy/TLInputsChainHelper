//
//  UIScrollView+FrameHelper.h
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import <UIKit/UIKit.h>

@interface UIScrollView (FrameHelper)

- (BOOL) isContentInsetZero;
-(void)animateInsetsToZero;

@end
