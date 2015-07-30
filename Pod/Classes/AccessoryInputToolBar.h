//
//  AccessoryInputToolBar.h
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AccessoryInputToolBarDelegate <NSObject>

@optional
- (void) doneButtonWasPressed;
- (void) previousButtonWasPressed:(id)sender;
- (void) nextButtonWasPressed:(id)sender;

@end

@interface AccessoryInputToolBar : UIToolbar


@property (nonatomic, strong) id<AccessoryInputToolBarDelegate>accesoryDelegate;
@property (nonatomic, strong) UIColor *accessoryButtonsTintColor;

- (id)initWithDelegate:(id<AccessoryInputToolBarDelegate>)delegate;

- (NSString*) doneButtonTitle;

- (void) setDoneButtonTitle:(NSString *)title;
- (void) setPreviousButtonTitle:(NSString *)title;
- (void) setNextButtonTitle:(NSString *)title;

- (void) hideTextFieldHighlighters;
- (void) showTextFieldHighlighters;


@end
