//
//  DBFlatPickerView.h
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import <UIKit/UIKit.h>


@protocol DBFlatPickerViewDelegate;

@interface DBFlatPickerView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UIView *view;
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UIView *selectionOverlayView;
    __weak IBOutlet NSLayoutConstraint *selectionHeightConstraint;
}

/// Array of displayed NSString
@property (nonatomic) NSArray <NSString*> *data;

/// Left margin of label
@property (nonatomic) IBInspectable CGFloat paddingLeft;

/// Right margin of label
@property (nonatomic) IBInspectable CGFloat paddingRight;

/// Height of rows
@property (nonatomic) IBInspectable CGFloat rowHeight;

/// Color of selection overlay (use colors with transparency)
@property (nonatomic) IBInspectable UIColor *selectionColor;

/// Delagate
@property (nonatomic, weak) id <DBFlatPickerViewDelegate> delegate;


/// Selects row
- (void)selectRow:(NSInteger)row;

@end


@protocol DBFlatPickerViewDelegate <NSObject>

@optional

/// Called when picker end row selection
- (void)flatPickerView:(DBFlatPickerView*)pickerView didSelectRow:(NSInteger)row;

/// Apply style to label
- (void)labelStyleForFlatPickerView:(DBFlatPickerView*)pickerView forLabel:(UILabel*)label;

@end

