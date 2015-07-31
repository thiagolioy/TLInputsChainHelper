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
    
    
    _inputsChainHelper.toolbarPreviousButtonTitle = @"Anterior";
    _inputsChainHelper.toolbarNextButtonTitle = @"Proximo";
    
//        _inputsChainHelper.toolbarDoneButtonTitle = @"OK";

    [_inputsChainHelper setToolbarDoneButtonTitle:@"Novo Titulo" forField:_textfield2];
    
    _inputsChainHelper.toolbarButtonsTintColor = [UIColor redColor];
    
    _inputsChainHelper.doneButtonBehavior = ResignOnClick;
    
    _inputsChainHelper.doneActionBlock = ^{
        NSLog(@"call DoneAction from block");
    };
    
    [_inputsChainHelper triggerOnField:_textfield2 actionBlock:^{
        NSLog(@"call actionField from block");
    }];
    
    _inputsChainHelper.showKeyboardCustomActionBlock = ^{

    };
    
    _inputsChainHelper.hideKeyboardCustomActionBlock = ^{
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
