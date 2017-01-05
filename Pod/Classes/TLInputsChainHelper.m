//
//  TLInputsChainHelper.m
//  Pods
//
//  Created by Itau on 5/21/15.
//
//

#import "TLInputsChainHelper.h"

@interface TLInputsChainHelper ()

@property(nonatomic,strong)UIView *viewBeeingHelped;
@property(nonatomic,strong)NSArray *textFields;
@property(nonatomic,strong)UIScrollView *containerScrollview;

@property(nonatomic,strong)UITextField *actionField;

@property(nonatomic,strong)UITextField *differentToolbarDoneTitleField;
@property(nonatomic,strong)NSString *differentToolbarDoneTitle;
@property(nonatomic,strong)NSString *defaultToolbarDoneTitle;

@property(nonatomic, copy) ActionBlockForField actionBlock;

@property(nonatomic,strong) AccessoryInputToolBar *formToolbar;

@end

@implementation TLInputsChainHelper


+(TLInputsChainHelper*)chainTextFields:(NSArray *)textFields
                                onView:(UIView*)view
                          withDelegate:(id<UITextFieldDelegate,UITextViewDelegate>)delegate
                               withToolbar:(BOOL)toolbar
                            andDismissTap:(BOOL)dismissTap{

    return [self chainTextFields:textFields onView:view withDelegate:delegate withToolbar:toolbar andDismissTap:dismissTap didTapViewAction:nil];
}

+(TLInputsChainHelper*)chainTextFields:(NSArray *)textFields
                                onView:(UIView*)view
                          withDelegate:(id<UITextFieldDelegate,UITextViewDelegate>)delegate
                           withToolbar:(BOOL)toolbar
                         andDismissTap:(BOOL)dismissTap
                      didTapViewAction:(DidTapViewActionBlock)didTapView{
    
    TLInputsChainHelper *helper = [TLInputsChainHelper new];
    helper.doneButtonBehavior = MoveToNextField;
    helper.didTapViewActionBlock = didTapView;
    helper.viewBeeingHelped = view;
    helper.textFields = textFields;
    [helper setTextFieldsDelegate:delegate];
    helper.keyboardAndTextfieldPadding = 10;
    if(toolbar)
        [helper addToolBar];
    if(dismissTap)
        [helper addBackgroundTapGesture];
    
    return helper;
}


-(void)setTextFieldsDelegate:(id<UITextFieldDelegate,UITextViewDelegate>)delegate{
    for(UITextField *tf in _textFields)
        tf.delegate = delegate;
}

-(void)removeTextFieldsDelegate{
    for(UITextField *tf in _textFields)
        tf.delegate = nil;
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

-(void)addRequestedFocusNotificationsOnScrollView:(UIScrollView*)scrollview {
    _containerScrollview = scrollview;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(determineScrollViewAdjustment:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)removeRequestedFocusNotificationsOnScrollView{
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
    [self showTextField:_currentTextField
     fromBehindKeyboard:kbFrame
  onContainerScrollView:_containerScrollview
            withPadding:_keyboardAndTextfieldPadding];
    if(_showKeyboardCustomActionBlock)
        _showKeyboardCustomActionBlock();
    
}

-(void)keyboardDidHide:(NSNotification *)notification {
//    [_containerScrollview setContentOffset:CGPointZero animated:YES];
    if(_hideKeyboardCustomActionBlock)
        _hideKeyboardCustomActionBlock();
}


-(void)showTextField:(UITextField*)textField fromBehindKeyboard:(CGRect)kbFrame
onContainerScrollView:(UIScrollView *)scrollView
          withPadding:(NSInteger)padding{
    
    if(!textField || ![textField isFirstResponder])
        return;
    
    CGRect textFieldFrame = [scrollView convertRect:textField.frame fromView:scrollView];
    
    CGFloat kbHeightWithPadding = kbFrame.size.height + padding;
    CGFloat containerHeight = _viewBeeingHelped.bounds.size.height;
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeightWithPadding, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    if(textFieldFrame.origin.y > containerHeight - kbHeightWithPadding){
        CGFloat y = fabs(textFieldFrame.origin.y - (containerHeight - kbHeightWithPadding));
        CGPoint scrollPoint = CGPointMake(0.0, y);
        [scrollView setContentOffset:scrollPoint animated:YES];
        
    }
}


-(void)addBackgroundTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [_viewBeeingHelped addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [TLInputsChainHelper findAndResignFirstResponder:_viewBeeingHelped];
    
    if(_didTapViewActionBlock)
        _didTapViewActionBlock();
}


-(void)setToolbarDoneButtonTitle:(NSString *)toolbarDoneButtonTitle{
    _toolbarDoneButtonTitle = toolbarDoneButtonTitle;
    [self addToolBar];
}

-(void)setToolbarNextButtonTitle:(NSString *)toolbarNextButtonTitle{
    _toolbarNextButtonTitle = toolbarNextButtonTitle;
    [self addToolBar];
}

-(void)setToolbarPreviousButtonTitle:(NSString *)toolbarPreviousButtonTitle{
    _toolbarPreviousButtonTitle = toolbarPreviousButtonTitle;
    [self addToolBar];
}

-(void)setToolbarButtonsTintColor:(UIColor *)toolbarButtonsTintColor{
    _toolbarButtonsTintColor = toolbarButtonsTintColor;
    [self addToolBar];
}


-(void)addToolBar {
    _formToolbar = [[AccessoryInputToolBar alloc] initWithDelegate:self];
    
    if(_toolbarDoneButtonTitle && _toolbarDoneButtonTitle.length > 0) {
        if(_doneButtonAccessibilityLabel && _doneButtonAccessibilityLabel.length > 0) {
            [_formToolbar setDoneButtonTitle:_toolbarDoneButtonTitle
                      withAccessibilityLabel:_doneButtonAccessibilityLabel];
        } else {
            [_formToolbar setDoneButtonTitle:_toolbarDoneButtonTitle];
        }
    }
    
    if(_toolbarNextButtonTitle && _toolbarNextButtonTitle.length > 0) {
        if(_nextButtonAccessibilityLabel && _nextButtonAccessibilityLabel.length > 0) {
            [_formToolbar setNextButtonTitle:_toolbarNextButtonTitle
                      withAccessibilityLabel:_nextButtonAccessibilityLabel];
        } else {
            [_formToolbar setNextButtonTitle:_toolbarNextButtonTitle];
        }
    }
    
    if(_toolbarPreviousButtonTitle && _toolbarPreviousButtonTitle.length > 0) {
        if(_previousButtonAccessibilityLabel && _previousButtonAccessibilityLabel.length > 0) {
            [_formToolbar setPreviousButtonTitle:_toolbarPreviousButtonTitle
                          withAccessibilityLabel: _previousButtonAccessibilityLabel];
        } else {
            [_formToolbar setPreviousButtonTitle:_toolbarPreviousButtonTitle];
        }
    }
    
    if(_toolbarButtonsTintColor)
        _formToolbar.accessoryButtonsTintColor = _toolbarButtonsTintColor;
    
    _defaultToolbarDoneTitle = _formToolbar.doneButtonTitle;
    
    for(UITextField *tf in _textFields)
        tf.inputAccessoryView = _formToolbar;
}

-(void)triggerOnField:(UITextField*)field actionBlock:(ActionBlockForField) block{
    _actionField = field;
    _actionBlock = block;
}

-(void)setToolbarDoneButtonTitle:(NSString *)title forField:(UITextField*) field{
    _differentToolbarDoneTitle = title;
    _differentToolbarDoneTitleField = field;
}

#pragma mark - TextFieldDelegate HelperMethods

-(BOOL)shouldReturn:(UITextField *)textField {
    [self doneButtonWasPressed];
    return YES;
}

-(void)didBeginEditing:(UITextField *)textField {
    _currentTextField = textField;
    [self setupToolbarForField:_currentTextField];
}

-(void)didEndEditing:(UITextField *)textField {
    _currentTextField = nil;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    _currentTextField = textView;
    [self setupToolbarForField:_currentTextField];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    _currentTextField = nil;
    
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
-(void)previousButtonWasPressed:(id)sender {
    UITextField *previousTextField = [self previous:_currentTextField];
    if (previousTextField)
        [previousTextField becomeFirstResponder];
}

-(void)nextButtonWasPressed:(id)sender {
    UITextField *nextTextField = [self next:_currentTextField];
    if (nextTextField)
        [nextTextField becomeFirstResponder];
}

-(void)setupToolbarForField:(UITextField*)field{
    if(field == _differentToolbarDoneTitleField)
        [_formToolbar setDoneButtonTitle:_differentToolbarDoneTitle];
    else
        [_formToolbar setDoneButtonTitle:_defaultToolbarDoneTitle];
}

-(void)doneButtonWasPressed{
    
    BOOL needed = [self triggerActionForFieldIfNeeded];
    if(needed)return;
    
    if(self.doneButtonBehavior == MoveToNextField)
        [self doneButtonWithNextBehavior];
    else
        [self doneButtonWithResignOnClickBehavior];
}


-(BOOL)triggerActionForFieldIfNeeded{
    BOOL needed = _currentTextField == _actionField;
    
    if(needed){
        [TLInputsChainHelper findAndResignFirstResponder:_currentTextField];
        if(_actionBlock)
            _actionBlock();
    }
    
    return needed;
}

-(void)doneButtonWithResignOnClickBehavior{
    if(_currentTextField == [_textFields lastObject] && _doneActionBlock)
        _doneActionBlock();
    
    [TLInputsChainHelper findAndResignFirstResponder:_currentTextField];
}

-(void)doneButtonWithNextBehavior{

    if(_currentTextField == [_textFields lastObject]){
        [TLInputsChainHelper findAndResignFirstResponder:_currentTextField];
        if(_doneActionBlock)
            _doneActionBlock();
    }else
        [self nextButtonWasPressed:nil];
}




@end
