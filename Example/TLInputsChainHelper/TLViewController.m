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
    // Dispose of any resources that can be recreated.
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


@end
