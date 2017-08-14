//
//  ViewController.m
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    pickerData = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6", @"Item 7", @"Item 8", @"Item 9", @"Item 10"];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self.picker selectRow:3];
}


#pragma mark - FlatPickerViewDelegate

- (NSString *)flatPickerView:(FlatPickerView *)flatPickerView titleForRow:(NSInteger)row {
    return [pickerData objectAtIndex:row];
}

- (void)flatPickerView:(FlatPickerView*)flatPickerView didSelectRow:(NSInteger)row {
    NSLog(@"selected row = %ld", (long)row);
    self.selectedRowLabel.text = [NSString stringWithFormat:@"Selected row = %ld", (long)row];
}

- (CGFloat)rowHeightForFlatPickerView:(FlatPickerView *)flatPickerView {
    return 60.0;
}

- (void)labelStyleForFlatPickerView:(FlatPickerView*)flatPickerView forLabel:(UILabel*)label {
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
}

#pragma mark - FlatPickerViewDataSource

- (NSInteger)numberOfRowsInFlatPickerView:(FlatPickerView*)flatPickerView {
    return [pickerData count];
}

@end
