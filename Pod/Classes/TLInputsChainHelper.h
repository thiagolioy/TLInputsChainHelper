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

+(TLInputsChainHelper*)helperForView:(UIView*)view withTextFields:(NSArray *)textFields;
+(BOOL)findAndResignFirstResponder:(UIView *)view;


-(void)addBackgroundTapGesture;
-(void)addToolBar;

-(void)setTextFieldsTag:(NSInteger)tag;
-(void)setTextFieldsDelegate:(id<UITextFieldDelegate>)delegate;
@end
