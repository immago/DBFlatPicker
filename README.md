# DBCameraButton
Flat picker for iOS written on Objective-C

![dbflatpicker](https://user-images.githubusercontent.com/5740772/29422075-bc3404a6-837f-11e7-9c2e-fd54a90567a0.gif)

## Installation
#### Manual
Copy DBFlatPickerView.h, DBFlatPickerView.m and DBFlatPickerView.xib from Classes directory to your project.

## Usage
```Objective-C
// Uncomment if picker not created in storyboard
// self.picker = [[DBFlatPickerView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
self.picker.data = @[@"item 1", @"item 2", @"item 3", @"item 4"];
self.picker.delegate = self;
[self.picker selectRow:2];

...

- (void)flatPickerView:(DBFlatPickerView*)flatPickerView didSelectRow:(NSInteger)row {
NSLog(@"selected row = %ld", (long)row);
}

- (void)labelStyleForFlatPickerView:(DBFlatPickerView*)flatPickerView forLabel:(UILabel*)label {
label.textColor = [UIColor blackColor];
label.font = [UIFont systemFontOfSize:20];
}

```

## Properties
```
NSArray <NSString*> *data - Array of displayed NSString
CGFloat paddingLeft - Left margin of label
CGFloat paddingRight - Right margin of label
CGFloat rowHeight - Height of rows
UIColor *selectionColor - Color of selection overlay (use colors with transparency)
```

## Delegates
```Objective-C
/// Called when picker end row selection
- (void)flatPickerView:(DBFlatPickerView*)pickerView didSelectRow:(NSInteger)row;

/// Apply style to label
- (void)labelStyleForFlatPickerView:(DBFlatPickerView*)pickerView forLabel:(UILabel*)label;
```
