InputViewController
===================

Simple view controller to provide an input view + input accessory view toolbar for 
UIViews with the setInputView and setInputAccessoryView methods; and manage screen positioning of
UIViews which would normally be hidden by the InputView.

Usage
=====

Copy files out of source/BBInputViewController to use.  source/ itself contains a driver program
to give example of how to use the BBInputViewController.  

There are 2 types of input provided: keyboard and the UIPickerView.  
Simply pass each View you want to setup into on of the initialize<XYZ> calls based 
on what type of input source is required.  It is important the UIView implements the
setInputView and setInputAccessoryView to use this class, if they don't then the controller won't set
these views accordingly.

When you become aware of view becoming firstResponder (e.g. textFieldShouldBeginEditing)
call the - (void) setInputView: (UIView*) hasNext: (BOOL) method.  

Implement BBInputViewControllerDelegate<NSObject> to recieve notifications of next/prev button being pressed.
Current implementation requires the client of this delegate to implement the responder ordering.

Note: It is up to clients to implement the correct protocols such PickerView delegate/datasource etc..

Toolbar
=======

Has three UIBarButtonItems.  

Done - simply calls resignFirstResponder, dismissing the inputview and resets screen position if necessary.  

Title is an optional centre title - call [setTitle: (NSString*) title] to set.

Prev/Next - a UISegmentControl to control navigation of responders via the BBInputViewControllerDelegate<NSObject>
delegate callback.

Localization
============

Use the following keys to localize the toolbar button titles:
"Done", "Prev", "Next"

Licence
=======

This software component is licenced under the MIT licence.  Please see source/licence.txt for full text.
