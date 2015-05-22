//
//  UIScrollView+FrameHelper.m
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import "UIScrollView+FrameHelper.h"

@implementation UIScrollView (FrameHelper)

- (BOOL) isContentInsetZero {
    UIEdgeInsets insets = self.contentInset;
    return insets.bottom == 0 && insets.left == 0 && insets.right == 0 && insets.top == 0;
}

-(void)animateInsetsToZero {
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.contentInset = contentInsets;
        self.scrollIndicatorInsets = contentInsets;
    }];
}


@end
