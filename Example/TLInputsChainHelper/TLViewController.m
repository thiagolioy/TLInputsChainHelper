//
//  TLViewController.m
//  TLInputsChainHelper
//
//  Created by Thiago Lioy on 05/15/2015.
//  Copyright (c) 2014 Thiago Lioy. All rights reserved.
//

#import "TLViewController.h"
#import <TLInputsChainHelper.h>


@interface TLViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)TLInputsChainHelper *inputsChainHelper;

@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInputsChainHelper];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_inputsChainHelper removeRequestedFocusNotificationsOnScrollView];
}

-(void)setupInputsChainHelper{
    NSArray *fields = @[
                        _textfield1,
                        _textfield2,
                        _textfield3,
                        _textfield4,
                        _textfield5
                        ];
    
    _inputsChainHelper = [TLInputsChainHelper chainTextFields:fields
                                  onView:self.view
                            withDelegate:self
                             withToolbar:YES
                           andDismissTap:YES];
    
    [_inputsChainHelper addRequestedFocusNotificationsOnScrollView:_containerScrollView];
    
    
    _inputsChainHelper.toolbarPreviousButtonTitle = @"<";
    _inputsChainHelper.toolbarNextButtonTitle = @">";
    
    _inputsChainHelper.toolbarButtonsTintColor = [UIColor blackColor];
    
    _inputsChainHelper.doneActionBlock = ^{
        NSLog(@"call DoneAction from block");
    };
}

#pragma mark - TextfieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_inputsChainHelper shouldReturn:textField];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [_inputsChainHelper didBeginEditing:textField];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [_inputsChainHelper didEndEditing:textField];
    
}



@end
