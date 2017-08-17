//
//  ViewController.h
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import <UIKit/UIKit.h>
#import "DBFlatPickerView.h"

@interface ViewController : UIViewController <DBFlatPickerViewDelegate>
{
    NSArray *colors;
}

@property (weak, nonatomic) IBOutlet DBFlatPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *selectedRowLabel;

@end

