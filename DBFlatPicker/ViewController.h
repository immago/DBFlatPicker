//
//  ViewController.h
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import <UIKit/UIKit.h>
#import "FlatPickerView.h"

@interface ViewController : UIViewController <FlatPickerViewDelegate>
{
    NSArray *colors;
}

@property (weak, nonatomic) IBOutlet FlatPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *selectedRowLabel;

@end

