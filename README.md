InputViewController
===================

simple view controller to provide a nice inputview + accessory view and manage screen positioning.

Usage
=====

copy files out of source/BBInputViewController to use.  source/ itself contains a driver program
to give example of how to use the BBInputViewController.  

There are 2 types of input provided: keyboard and the UIPickerView.  
Simply pass each View you want to setup into on of the initialize<XYZ> calls based 
on what type of input source is required.  It is important the UIView implements the
setInputView and setInputAccessoryView to use this class, if they don't then the controller won't set
these views accordingly.

When you become aware of view becoming firstResponder (e.g. textFieldShouldBeginEditing)
call the - (void) setInputView: hasNext: method.  This will move the screen up if needed and set
the Done/Next button based on the hasNext: boolean parameter.

Implement BBInputViewControllerDelegate<NSObject> to recieve notifications of next button being pressed.
If the button is in 'Done' mode - the responder is resigned and this protocol's message is not called.

Note: It is up to clients to implement the correct protocols such PickerView delegate/datasource etc..
