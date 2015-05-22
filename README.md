# TLInputsChainHelper

[![Twitter: @tplioy](https://img.shields.io/badge/contact-@tplioy-blue.svg?style=flat)](https://twitter.com/tplioy)
[![CI Status](http://img.shields.io/travis/thiagolioy/TLInputsChainHelper.svg?style=flat)](https://travis-ci.org/thiagolioy/TLInputsChainHelper)
[![Version](https://img.shields.io/cocoapods/v/TLInputsChainHelper.svg?style=flat)](http://cocoapods.org/pods/TLInputsChainHelper)
[![License](https://img.shields.io/cocoapods/l/TLInputsChainHelper.svg?style=flat)](http://cocoapods.org/pods/TLInputsChainHelper)
[![Platform](https://img.shields.io/cocoapods/p/TLInputsChainHelper.svg?style=flat)](http://cocoapods.org/pods/TLInputsChainHelper)

## What it does ?

Chain your textfields and handle scroll to them on request focus really easy .

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TLInputsChainHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TLInputsChainHelper"
```

## Usage
```ruby
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

    _inputsChainHelper.doneActionBlock = ^{
        NSLog(@"call DoneAction from block");
    };

    #Optional Configuration. Will use default values if not passed
    _inputsChainHelper.toolbarPreviousButtonTitle = @"<";
    _inputsChainHelper.toolbarNextButtonTitle = @">";
    _inputsChainHelper.toolbarButtonsTintColor = [UIColor blackColor];
}

```


## Author

Thiago Lioy, lioyufrj@gmail.com

## License

TLInputsChainHelper is available under the MIT license. See the LICENSE file for more info.
