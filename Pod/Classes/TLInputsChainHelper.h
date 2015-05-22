//
//  TLInputsChainHelper.h
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import <Foundation/Foundation.h>
#import "AccessoryInputToolBar.h"

typedef void (^DoneActionBlock)();
@interface TLInputsChainHelper : NSObject<AccessoryInputToolBarDelegate>

@property(nonatomic, copy) DoneActionBlock doneActionBlock;
@property(nonatomic,strong)UITextField *currentTextField;
@property(nonatomic,assign)NSInteger keyboardAndTextfieldPadding;

@property(nonatomic,strong)UIColor *toolbarButtonsTintColor;
@property(nonatomic,strong)NSString *toolbarDoneButtonTitle;
@property(nonatomic,strong)NSString *toolbarNextButtonTitle;
@property(nonatomic,strong)NSString *toolbarPreviousButtonTitle;

+(TLInputsChainHelper*)chainTextFields:(NSArray *)textFields
                                onView:(UIView*)view
                          withDelegate:(id<UITextFieldDelegate>)delegate
                           withToolbar:(BOOL)toolbar
                         andDismissTap:(BOOL)dismissTap;

-(void)addBackgroundTapGesture;
-(void)addToolBar;

-(void)addRequestedFocusNotificationsOnScrollView:(UIScrollView*)scrollview;
-(void)removeRequestedFocusNotificationsOnScrollView;

-(BOOL)shouldReturn:(UITextField *)textField;
-(void)didBeginEditing:(UITextField *)textField;
-(void)didEndEditing:(UITextField *)textField;
@end
