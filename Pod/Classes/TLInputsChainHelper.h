//
//  TLInputsChainHelper.h
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import <Foundation/Foundation.h>
#import "AccessoryInputToolBar.h"

typedef void (^ShowKeyboardCustomActionBlock)();
typedef void (^HideKeyboardCustomActionBlock)();
typedef void (^DoneActionBlock)();
typedef void (^DidTapViewActionBlock)();

typedef void (^ActionBlockForField)();


typedef NS_ENUM(NSInteger, DoneButtonBehavior) {
    MoveToNextField,
    ResignOnClick
};

@interface TLInputsChainHelper : NSObject<AccessoryInputToolBarDelegate>

@property(nonatomic, copy) ShowKeyboardCustomActionBlock showKeyboardCustomActionBlock;
@property(nonatomic, copy) HideKeyboardCustomActionBlock hideKeyboardCustomActionBlock;
@property(nonatomic, copy) DoneActionBlock doneActionBlock;
@property(nonatomic, copy) DidTapViewActionBlock didTapViewActionBlock;

@property(nonatomic,strong)UITextField *currentTextField;
@property(nonatomic,assign)NSInteger keyboardAndTextfieldPadding;

@property(nonatomic,strong)UIColor *toolbarButtonsTintColor;
@property(nonatomic,strong)NSString *toolbarDoneButtonTitle;
@property(nonatomic,strong)NSString *toolbarNextButtonTitle;
@property(nonatomic,strong)NSString *toolbarPreviousButtonTitle;

@property(nonatomic,strong)NSString *previousButtonAccessibilityLabel;
@property(nonatomic,strong)NSString *nextButtonAccessibilityLabel;
@property(nonatomic,strong)NSString *doneButtonAccessibilityLabel;

@property(nonatomic,assign)DoneButtonBehavior doneButtonBehavior;

+(TLInputsChainHelper*)chainTextFields:(NSArray *)textFields
                                onView:(UIView*)view
                          withDelegate:(id<UITextFieldDelegate,UITextViewDelegate>)delegate
                               withToolbar:(BOOL)toolbar
                            andDismissTap:(BOOL)dismissTap;

+(TLInputsChainHelper*)chainTextFields:(NSArray *)textFields
                                onView:(UIView*)view
                          withDelegate:(id<UITextFieldDelegate,UITextViewDelegate>)delegate
                           withToolbar:(BOOL)toolbar
                         andDismissTap:(BOOL)dismissTap
                      didTapViewAction:(DidTapViewActionBlock)didTapView;

-(void)removeTextFieldsDelegate;
-(void)addBackgroundTapGesture;
-(void)addToolBar;

-(void)addRequestedFocusNotificationsOnScrollView:(UIScrollView*)scrollview;
-(void)removeRequestedFocusNotificationsOnScrollView;

-(BOOL)shouldReturn:(UITextField *)textField;
-(void)didBeginEditing:(UITextField *)textField;
-(void)didEndEditing:(UITextField *)textField;

-(void)setToolbarDoneButtonTitle:(NSString *)title forField:(UITextField*) field;
-(void)triggerOnField:(UITextField*)field actionBlock:(ActionBlockForField) block;

-(void)textViewDidBeginEditing:(UITextView *)textView;
-(void)textViewDidEndEditing:(UITextView *)textView;

@end
