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

    colors = @[[UIColor lightGrayColor], [UIColor greenColor], [UIColor whiteColor],
               [UIColor cyanColor], [UIColor orangeColor], [UIColor magentaColor],
               [UIColor redColor], [UIColor blueColor], [UIColor brownColor], [UIColor grayColor]];
    
    // picker
    self.picker.data = @[@"light gray", @"green", @"white", @"cyan", @"orange", @"magenta", @"red", @"blue", @"brown", @"gray"];
    self.picker.delegate = self;
    [self.picker selectRow:2];
}


#pragma mark - FlatPickerViewDelegate


- (void)flatPickerView:(FlatPickerView*)flatPickerView didSelectRow:(NSInteger)row {
    NSLog(@"selected row = %ld", (long)row);
    self.selectedRowLabel.text = [NSString stringWithFormat:@"%@ color\n(row = %ld)", self.picker.data[row], (long)row];
    self.view.backgroundColor = colors[row];
}

- (void)labelStyleForFlatPickerView:(FlatPickerView*)flatPickerView forLabel:(UILabel*)label {
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
}

@end
