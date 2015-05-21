//
//  TLInputsChainHelper.m
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import "TLInputsChainHelper.h"

@interface TLInputsChainHelper ()

@property(nonatomic,strong)UIView *viewBeeingHelped;
@property(nonatomic,strong)NSArray *textFields;

-(void)tappedBackground:(UITapGestureRecognizer *)gestureRecognizer ;
@end

@implementation TLInputsChainHelper
-(void)setTextFieldsTag:(NSInteger)tag{
    for(UITextField *tf in _textFields)
        tf.tag = tag;
}

-(void)setTextFieldsDelegate:(id<UITextFieldDelegate>)delegate{
    for(UITextField *tf in _textFields)
        tf.delegate = delegate;
}

+(TLInputsChainHelper*)helperForView:(UIView*)view withTextFields:(NSArray *)textFields{
    TLInputsChainHelper *helper = [TLInputsChainHelper new];
    helper.viewBeeingHelped = view;
    helper.textFields = textFields;
    return helper;
}
+(BOOL)findAndResignFirstResponder:(UIView *)view {
    if (view.isFirstResponder) {
        [view resignFirstResponder];
        return YES;
    }
    for (UIView *subView in view.subviews) {
        if ([TLInputsChainHelper findAndResignFirstResponder:subView]) {
            return YES;
        }
    }
    return NO;
}



-(void)addBackgroundTapGesture {
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:_viewBeeingHelped action:@selector(tappedBackground:)];
    tapBackground.cancelsTouchesInView = NO;
    [_viewBeeingHelped addGestureRecognizer:tapBackground];
}

-(void)addToolBar {
    AccessoryInputToolBar *formToolbar = [[AccessoryInputToolBar alloc] initWithDelegate:self];
    for(UITextField *tf in _textFields)
        tf.inputAccessoryView = formToolbar;
}


- (void) doneButtonWasPressed{
    if(_currentTextField == [_textFields lastObject]){
        [TLInputsChainHelper findAndResignFirstResponder:_currentTextField];
        if(_doneActionBlock)
            _doneActionBlock();
    }else
        [self nextButtonWasPressed:nil];
}


#pragma mark - Private Methods

-(UITextField *)previous:(UITextField *)currentTextField{
    NSInteger textFieldIndex = [_textFields indexOfObject:currentTextField];
    if (textFieldIndex > 0){
        if ((textFieldIndex - 1) < _textFields.count)
            return [_textFields objectAtIndex:textFieldIndex - 1];
    }
    return nil;
}

-(UITextField *)next:(UITextField *)currentTextField{
    NSInteger textFieldIndex = [_textFields indexOfObject:currentTextField];
    if (textFieldIndex < _textFields.count - 1)
        return [_textFields objectAtIndex:textFieldIndex + 1];
    return nil;
}
#pragma mark - TOOLBAR methods
- (void) previousButtonWasPressed:(id)sender {
    UITextField *previousTextField = [self previous:_currentTextField];
    if (previousTextField)
        [previousTextField becomeFirstResponder];
}

- (void) nextButtonWasPressed:(id)sender {
    UITextField *nextTextField = [self next:_currentTextField];
    if (nextTextField)
        [nextTextField becomeFirstResponder];
}


-(void)tappedBackground:(UITapGestureRecognizer *)gestureRecognizer {
    [TLInputsChainHelper findAndResignFirstResponder:_viewBeeingHelped];
}
@end
