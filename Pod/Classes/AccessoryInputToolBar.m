//
//  AccessoryInputToolBar.m
//  Pods
//
//  Created by Thiago Lioy on 5/21/15.
//
//

#import "AccessoryInputToolBar.h"

@interface AccessoryInputToolBar()

@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) UIBarButtonItem *previousField;
@property (nonatomic, strong) UIBarButtonItem *nextField;

@end


@implementation AccessoryInputToolBar
- (id)init {
    self = [super init];
    if (self) {
        [self initializeView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeView];
    }
    return self;
}

- (id)initWithDelegate:(id<AccessoryInputToolBarDelegate>)delegate {
    self = [super init];
    if (self) {
        self.accesoryDelegate = delegate;
        [self initializeView];
    }
    return self;
}

- (void) initializeView {
    [self initializeDoneButton];
    [self initializePreviousFieldButton];
    [self initializeNextFieldButton];
    [self initializeToolbar];
}

- (void) initializeToolbar {
    [self sizeToFit];
    self.tintColor = _accessoryButtonsTintColor;
    [self setItems:@[self.previousField, self.nextField, [self flexibleSeparator], self.doneButton]];
}

- (void) initializeDoneButton {
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"ok"
                                                       style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(doneButtonWasPressed)];
    self.doneButton.tintColor = _accessoryButtonsTintColor;
    self.doneButton.accessibilityIdentifier = @"KEYBOARD_OK_BUTTON";
}

- (void) initializePreviousFieldButton {
    self.previousField = [[UIBarButtonItem alloc] initWithTitle:@"Anterior"
                                                          style:UIBarButtonItemStyleDone
                                                         target:self
                                                         action:@selector(goToPreviousField:)];
    self.previousField.tintColor = _accessoryButtonsTintColor;
    self.previousField.accessibilityIdentifier = @"KEYBOARD_NEXT_BUTTON";
}

- (void) initializeNextFieldButton {
    self.nextField = [[UIBarButtonItem alloc] initWithTitle:@"Próximo"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(goToNextField:)];
    self.nextField.tintColor = _accessoryButtonsTintColor;
    self.nextField.accessibilityIdentifier = @"KEYBOAR_PREVIOUS_BUTTON";
}

- (UIBarButtonItem *) flexibleSeparator {
    UIBarButtonItem *flexibleSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
    return flexibleSeparator;
}

-(void)setAccessoryButtonsTintColor:(UIColor *)accessoryButtonsTintColor{
    _accessoryButtonsTintColor = accessoryButtonsTintColor;
    self.doneButton.tintColor = _accessoryButtonsTintColor;
    self.nextField.tintColor = _accessoryButtonsTintColor;
    self.previousField.tintColor = _accessoryButtonsTintColor;
}

- (void) setDoneButtonTitle:(NSString *)title {
    self.doneButton.title = title;
}

- (void) setPreviousButtonTitle:(NSString *)title {
    self.previousField.title = title;
}

- (void) setNextButtonTitle:(NSString *)title {
    self.nextField.title = title;
}

- (void) setNextButtonTitle:(NSString *)title withAccessibilityLabel:(NSString *)label {
    self.nextField.title = title;
    self.nextField.accessibilityLabel = label;
}

- (void) setPreviousButtonTitle:(NSString *)title withAccessibilityLabel:(NSString *)label {
    self.previousField.title = title;
    self.previousField.accessibilityLabel = label;
}

- (void) setDoneButtonTitle:(NSString *)title withAccessibilityLabel:(NSString *)label {
    self.doneButton.title = title;
    self.doneButton.accessibilityLabel = label;
}

- (void)hideTextFieldHighlighters {
    [self setItems:@[[self flexibleSeparator], self.doneButton]];
}

- (void)showTextFieldHighlighters {
    [self setItems:@[self.previousField, self.nextField, [self flexibleSeparator], self.doneButton]];
}

- (void) doneButtonWasPressed{
    if (self.accesoryDelegate && [self.accesoryDelegate respondsToSelector:@selector(doneButtonWasPressed)]) {
        [self.accesoryDelegate doneButtonWasPressed];
    }
}

- (void) goToPreviousField:(id)sender {
    if (self.accesoryDelegate && [self.accesoryDelegate respondsToSelector:@selector(previousButtonWasPressed:)]) {
        [self.accesoryDelegate previousButtonWasPressed:sender];
    }
}

- (void) goToNextField:(id)sender {
    if (self.accesoryDelegate && [self.accesoryDelegate respondsToSelector:@selector(nextButtonWasPressed:)]) {
        [self.accesoryDelegate nextButtonWasPressed:sender];
    }
}

- (NSString*) doneButtonTitle{
    return self.doneButton.title;
}

@end
