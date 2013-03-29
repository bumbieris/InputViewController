//
//  BBTestViewController.m
//  temp
//
//  Created by bumbieris on 24/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBInputViewControllerDelegate;

@interface BBInputViewController : UIViewController
{
    CGFloat _yOff;
}
@property (nonatomic, strong) IBOutlet UIPickerView* pickerView;
@property (nonatomic, strong) IBOutlet UIToolbar* toolbar;
@property (nonatomic) CGFloat extraY;
@property (readonly) UIView* currentInput;
@property (weak, nonatomic) UIView* containerView;
@property (weak, nonatomic) id<BBInputViewControllerDelegate> delegate;

- (void) initializeControlWithPicker: (UIView*) control
            pickerDelegate: (id<UIPickerViewDelegate>) pickerDelegate
          pickerDataSource: (id<UIPickerViewDataSource>) pickerDataSource;

- (void) initializeControlWithKeyboard: (UIView*) control;

- (void) setInputView: (UIView*) inputView hasNext: (BOOL) hasNext;
- (void) resignInputView;

- (void) setTitle: (NSString*)title;

- (id) initWithContainerView: (UIView*) view delegate: (id<BBInputViewControllerDelegate>) delegate;
- (void) setInputView: (UIView*) inputView hasNext: (BOOL) hasNext title: (NSString*) title;

@end

@protocol BBInputViewControllerDelegate<NSObject>
- (void) inputViewController: (BBInputViewController*) controller nextPressedForInput: (UIView*) input;
- (void) inputViewController: (BBInputViewController*) controller prevPressedForInput: (UIView*) input;
@end
