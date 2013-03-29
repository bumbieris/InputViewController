//
//  BBTestViewController.m
//  temp
//
//  Created by bumbieris on 24/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import "BBTestViewController.h"
#import "BBInputViewController.h"

@interface BBTestViewController ()<UITextFieldDelegate,
            UIPickerViewDataSource, UIPickerViewDelegate, BBInputViewControllerDelegate>
@property (nonatomic, strong) IBOutlet UITextField *text0;
@property (nonatomic, strong) IBOutlet UITextField *text1;
@property (nonatomic, strong) IBOutlet UITextField *text2;
@property (nonatomic, strong) BBInputViewController *pickerController;
@end

@implementation BBTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.pickerController = //[self.storyboard instantiateViewControllerWithIdentifier:@"pickercontroller"];
    [[BBInputViewController alloc] initWithContainerView:self.view delegate:self];
    _pickerController.extraY = 10;
    _pickerController.toolbar.tintColor = [UIColor blackColor];
    
//    [_pickerController setContainerView: self.view];
    [_pickerController initializeControlWithPicker:_text0 pickerDelegate:self pickerDataSource:self];
    [_pickerController initializeControlWithPicker:_text2 pickerDelegate:self pickerDataSource:self];
    [_pickerController initializeControlWithKeyboard:_text1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [_pickerController setInputView: textField title:textField.placeholder];
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{

}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"Item %d", row];
}

- (void) inputViewController:(BBInputViewController *)controller nextPressedForInput:(UIView *)input
{
    UIView* next=nil;
    if (input ==_text0)
        next=_text1;
    else if (input ==_text1)
        next=_text2;
    [next becomeFirstResponder];
}

- (void) inputViewController: (BBInputViewController*) controller prevPressedForInput: (UIView*) input
{
    UIView* next=nil;
    if (input ==_text2)
        next=_text1;
    else if (input ==_text1)
        next=_text0;
    [next becomeFirstResponder];
}

@end
