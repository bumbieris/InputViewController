//
//  BBTestViewController.m
//  temp
//
//  Created by bumbieris on 24/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import "BBInputViewController.h"

@interface BBInputViewController ()
@property(nonatomic, weak) IBOutlet UIBarButtonItem* doneButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem* titleButton;
@property(nonatomic, weak) IBOutlet UISegmentedControl* prevNextControl;
- (IBAction) segmentValueChanged: (UISegmentedControl*) ctrl;
- (IBAction) donePressed: (id) button;
- (void) initializeIfNot;
@end

@implementation BBInputViewController

- (id) init
{
    self = [super initWithNibName:@"BBInputViewController" bundle:nil];
    return self;
}

- (id) initWithContainerView: (UIView*) view delegate: (id<BBInputViewControllerDelegate>) delegate
{
    if (self = [super initWithNibName:@"BBInputViewController" bundle:nil]){
        _containerView = view;
        _delegate = delegate;
    }
    return self;
}

- (void) setInputView: (UIView*) inputView title: (NSString*) title
{
    [self setInputView:inputView];
    [self setTitle:title];
}

- (void) initializeControlWithPicker: (UIView*) control
                      pickerDelegate: (id<UIPickerViewDelegate>) pickerDelegate
                    pickerDataSource: (id<UIPickerViewDataSource>) pickerDataSource;
{
    
    [self initializeIfNot];
    
    if ([control respondsToSelector:@selector(setInputAccessoryView:)])
        [control performSelector:@selector(setInputAccessoryView:) withObject: _toolbar];

    if ([control respondsToSelector:@selector(setInputView:)]){
        [control performSelector:@selector(setInputView:) withObject:_pickerView];
        _pickerView.delegate = pickerDelegate;
        _pickerView.dataSource = pickerDataSource;
    }
}

- (void) initializeControlWithKeyboard: (UIView*) control
{
    [self initializeIfNot];
    
    if ([control respondsToSelector:@selector(setInputAccessoryView:)])
        [control performSelector:@selector(setInputAccessoryView:) withObject: _toolbar];
    
    if ([control respondsToSelector:@selector(setInputView:)])
        [control performSelector:@selector(setInputView:) withObject:nil];
}

- (void) setInputView: (UIView*) inputView
{
    UIView* vcView = _containerView;
        
    CGRect r = [vcView.window convertRect:inputView.frame fromView:inputView.superview];
    CGFloat yOff = vcView.window.frame.size.height + _yOff - CGRectGetMaxY(r) - 260 - _extraY;
    
    if (yOff > 0)
        yOff = 0;
    
    if (vcView.frame.origin.y != yOff){
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = vcView.frame;
            f.origin.y = yOff;
            vcView.frame = f;
        }];
    }
    
    if (inputView == nil)
        [_currentInput resignFirstResponder];
    
    _currentInput = inputView;
    _yOff = yOff;

}

- (void) resignInputView
{
    [self setInputView:nil];
}

- (void) setTitle: (NSString*)title
{
    _titleButton.title = title;
}


- (UIToolbar*) toolbar
{
    [self initializeIfNot];
    return _toolbar;
}

- (UIPickerView*) pickerView
{
    [self initializeIfNot];
    return _pickerView;
}

#pragma mark - private

- (void) initializeIfNot
{
    // as the nib is just being used as a container the loadview is typically not being called
    // and not wiring up the controls - so do a lazy initialize here
    if (_toolbar == nil){
        [self loadView];
        [_prevNextControl setTitle:NSLocalizedString(@"Prev", @"Prev") forSegmentAtIndex:0];
        [_prevNextControl setTitle:NSLocalizedString(@"Next", @"Next") forSegmentAtIndex:0];
        _doneButton.title = NSLocalizedString(@"Done", @"Done");
    }
}

- (IBAction) donePressed: (id) button
{
    [self resignInputView];
}

- (IBAction) segmentValueChanged: (UISegmentedControl*) ctrl
{
    if (ctrl.selectedSegmentIndex == 0)
        [_delegate inputViewController:self prevPressedForInput:_currentInput];
    else
        [_delegate inputViewController:self nextPressedForInput:_currentInput];
}


@end
