//
//  UIViewController+FirstResponder.h
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (FirstResponder)

-(void) pushTextField:(UITextField*)textField fromBehindKeyboard:(CGRect)kbFrame
onContainerScrollView:(UIScrollView *)scrollView
          withPadding:(NSInteger)padding;

@end
