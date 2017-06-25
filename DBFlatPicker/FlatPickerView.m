//
//  FlatPickerView.m
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import "FlatPickerView.h"

#define CELL_LABEL_TAG 100

@implementation FlatPickerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    
    // 1. load the interface
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    // 2. add as subview
    [self addSubview:self.view];
    // 3. allow for autolayout
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    // 4. add constraints to span entire view
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // Pass all touches to table view
    return self.tableView;
}

- (void)selectRow:(NSInteger)row {
    CGFloat rowHeight = [self.delegate rowHeightForFlatPickerView:self];
    [self.tableView setContentOffset:CGPointMake(0.0, row * rowHeight)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.tableView.backgroundColor = backgroundColor;
}

#pragma mark - UITableViewDelegate functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInFlatPickerView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = [self.delegate rowHeightForFlatPickerView:self];
    
    static NSString *cellIdentifier = @"FlatPickerViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel *textLabel;
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.paddingLeft, 0.0, self.frame.size.width - self.paddingLeft - self.paddingRight, rowHeight)];
        textLabel.tag = CELL_LABEL_TAG;
        textLabel.text = [self.delegate flatPickerView:self titleForRow:indexPath.row];
        textLabel.backgroundColor = [UIColor clearColor];
        [self.delegate labelStyleForFlatPickerView:self forLabel:textLabel];
        
        [cell.contentView addSubview:textLabel];
        
    } else {
        textLabel = (UILabel*)[cell.contentView viewWithTag:CELL_LABEL_TAG];
        textLabel.text = [self.delegate flatPickerView:self titleForRow:indexPath.row];
    }
    
    textLabel.frame = CGRectMake(self.paddingLeft,
                                 (indexPath.row == 0) ? self.selectionOverlayView.frame.origin.y : 0.0,
                                 self.frame.size.width - self.paddingLeft - self.paddingRight,
                                 rowHeight);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat rowHeight = [self.delegate rowHeightForFlatPickerView:self];
    
    // Top and bottom padding
    if (indexPath.row == 0) {
        return (self.selectionOverlayView.frame.origin.y + rowHeight);
        
    } else if (indexPath.row == [self.dataSource numberOfRowsInFlatPickerView:self] - 1) {
        return (self.selectionOverlayView.frame.origin.y + rowHeight);
    }
    return rowHeight;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat rowHeight = [self.delegate rowHeightForFlatPickerView:self];
    
    // Scroll to next multiple of rowHeight
    CGFloat floatVal = targetContentOffset->y / rowHeight;
    NSInteger rounded = (NSInteger)(lround(floatVal));
    targetContentOffset->y = rounded * rowHeight;
    [self.delegate flatPickerView:self didSelectRow:rounded];
}


@end
