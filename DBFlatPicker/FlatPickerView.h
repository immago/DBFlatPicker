//
//  FlatPickerView.h
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import <UIKit/UIKit.h>


@protocol FlatPickerViewDelegate;
@protocol FlatPickerViewDataSource;

@interface FlatPickerView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *selectionOverlayView;
@property (nonatomic) IBInspectable CGFloat paddingLeft;
@property (nonatomic) IBInspectable CGFloat paddingRight;
@property (nonatomic, weak) id <FlatPickerViewDelegate> delegate;
@property (nonatomic, weak) id <FlatPickerViewDataSource> dataSource;

- (void)selectRow:(NSInteger)row;
@end


@protocol FlatPickerViewDelegate
- (NSString *)flatPickerView:(FlatPickerView*)pickerView titleForRow:(NSInteger)row;
- (void)flatPickerView:(FlatPickerView*)pickerView didSelectRow:(NSInteger)row;
- (CGFloat)rowHeightForFlatPickerView:(FlatPickerView*)pickerView;
- (void)labelStyleForFlatPickerView:(FlatPickerView*)pickerView forLabel:(UILabel*)label;
@end

@protocol FlatPickerViewDataSource
- (NSInteger)numberOfRowsInFlatPickerView:(FlatPickerView*)pickerView;
@end
