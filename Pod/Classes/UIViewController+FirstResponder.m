//
//  UIViewController+FirstResponder.m
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import "UIViewController+FirstResponder.h"

@implementation UIViewController (FirstResponder)


-(void) pushTextField:(UITextField*)textField fromBehindKeyboard:(CGRect)kbFrame
                                           onContainerScrollView:(UIScrollView *)scrollView
                                                     withPadding:(NSInteger)padding{
    
    CGRect textFieldFrame = [scrollView convertRect:textField.frame fromView:scrollView];
    
    CGFloat kbHeightWithPadding = kbFrame.size.height + padding;
    CGFloat containerHeight = self.view.bounds.size.height;
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeightWithPadding, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    if(textFieldFrame.origin.y > containerHeight - kbHeightWithPadding){
        CGFloat y = fabs(textFieldFrame.origin.y - (containerHeight - kbHeightWithPadding));
        CGPoint scrollPoint = CGPointMake(0.0, y);
        [scrollView setContentOffset:scrollPoint animated:YES];
        
    }
}

@end
