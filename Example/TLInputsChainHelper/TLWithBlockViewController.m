//
//  TLWithBlockViewController.m
//  TLInputsChainHelper
//
//  Created by Andre Vieira on 09/12/15.
//  Copyright © 2015 Thiago Lioy. All rights reserved.
//

#import "TLWithBlockViewController.h"


@interface TLWithBlockViewController ()

@property(nonatomic,strong)TLInputsChainHelper *inputsChainHelper;

@end

@implementation TLWithBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInputsChainHelper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupInputsChainHelper{
    NSArray *fields = @[
                        _textfield1
                        ];
    
    _inputsChainHelper = [TLInputsChainHelper chainTextFields:fields
                                                       onView:self.view
                                                 withDelegate:self
                                                  withToolbar:YES
                                                andDismissTap:YES didTapViewAction:^{
                                                    NSLog(@"click on view");
                                                }];
    
    
    _inputsChainHelper.toolbarPreviousButtonTitle = @"Anterior";
    _inputsChainHelper.toolbarNextButtonTitle = @"Proximo";

    
    _inputsChainHelper.toolbarButtonsTintColor = [UIColor redColor];
    
    _inputsChainHelper.doneButtonBehavior = ResignOnClick;
    
    _inputsChainHelper.doneActionBlock = ^{
        NSLog(@"call DoneAction from block");
    };
    
    _inputsChainHelper.showKeyboardCustomActionBlock = ^{
        
    };
    
    _inputsChainHelper.hideKeyboardCustomActionBlock = ^{
    };
}

#pragma mark - TextField Delegate
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
