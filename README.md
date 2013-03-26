InputViewController
===================

Simple view controller to provide an input view + input accessory view toolbar for 
UIViews with the setInputView and setInputAccessoryView methods; and manage screen positioning of
UIViews which would normally be hidden by the InputView.

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
call the - (void) setInputView: (UIView*) hasNext: (BOOL) method.  This will move the screen up if needed and set
the Done/Next button on the toolbar based on the hasNext: boolean parameter.

Implement BBInputViewControllerDelegate<NSObject> to recieve notifications of next button being pressed.
If the button is in 'Done' mode - the responder is resigned and this protocol's message is not called.

Note: It is up to clients to implement the correct protocols such PickerView delegate/datasource etc..

Toolbar
=======

Has three UIBarButtonItems.  

Cancel - simply calls resignFirstResponder, dismissing the inputview and resets screen position if necessary.  

Title is an optional centre title - call [setTitle: (NSString*) title] to set.

Next/Done is a simple means of chaining responders together.  If the button is in 'Next' state 
it will call the BBInputViewControllerDelegate delegate (if set) to allow the client to pass a 
next UIView in via the setInputView: hasNext: message.

If the button is in 'Done' state - it simply does same as Cancel.

Localization
============

Use the following keys to localize the toolbar button titles:
"Cancel", "Next", "Done"
