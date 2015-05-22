//
//  TLViewController.m
//  TLInputsChainHelper
//
//  Created by Thiago Lioy on 05/15/2015.
//  Copyright (c) 2014 Thiago Lioy. All rights reserved.
//

#import "TLViewController.h"
#import <TLInputsChainHelper.h>
#import <TLInputsChainHelper/UIScrollView+FrameHelper.h>
#import <TLInputsChainHelper/UIViewController+FirstResponder.h>

@interface TLViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)TLInputsChainHelper *inputsChainHelper;

@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNotifications];
    [self setupInputsChainHelper];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self removeNotifications];
}

-(void)setupInputsChainHelper{
    _inputsChainHelper = [TLInputsChainHelper helperForView:self.view
                                             withTextFields:@[
                                                              _textfield1,
                                                              _textfield2,
                                                              _textfield3,
                                                              _textfield4,
                                                              _textfield5
                                                              ]];
    
    [_inputsChainHelper setTextFieldsDelegate:self];
    [_inputsChainHelper addToolBar];
    [_inputsChainHelper addBackgroundTapGesture];
    
    _inputsChainHelper.doneActionBlock = ^{
        NSLog(@"call DoneAction from block");
    };
}

#pragma mark - TextfieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_inputsChainHelper doneButtonWasPressed];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    _inputsChainHelper.currentTextField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    _inputsChainHelper.currentTextField = nil;
    
}

#pragma mark - Notifications Observers

- (void) addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(determineScrollViewAdjustment:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Handle Keyboard Notifications
-(void)determineScrollViewAdjustment:(NSNotification *)notification {
    CGRect kbFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self pushTextField:_inputsChainHelper.currentTextField
     fromBehindKeyboard:kbFrame onContainerScrollView:_containerScrollView withPadding:10];

}

-(void)keyboardDidHide:(NSNotification *)notification {
    [_containerScrollView setContentOffset:CGPointZero animated:YES];
}



@end
