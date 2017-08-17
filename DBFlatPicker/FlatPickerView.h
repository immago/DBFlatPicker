//
//  FlatPickerView.h
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import <UIKit/UIKit.h>


@protocol FlatPickerViewDelegate;

@interface FlatPickerView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *selectionOverlayView;

@property (nonatomic) NSArray <NSString*> *data;
@property (nonatomic) IBInspectable CGFloat paddingLeft;
@property (nonatomic) IBInspectable CGFloat paddingRight;
@property (nonatomic) IBInspectable CGFloat rowHeight;
@property (nonatomic, weak) id <FlatPickerViewDelegate> delegate;

- (void)selectRow:(NSInteger)row;

@end


@protocol FlatPickerViewDelegate <NSObject>

@optional
- (void)flatPickerView:(FlatPickerView*)pickerView didSelectRow:(NSInteger)row;
- (void)labelStyleForFlatPickerView:(FlatPickerView*)pickerView forLabel:(UILabel*)label;

@end

