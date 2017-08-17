//
//  DBFlatPickerView.m
//  DBFlatPicker
//
//  Created by Dmitry Byankin on 25.06.17.
//

#import "DBFlatPickerView.h"

#define CELL_LABEL_TAG 100


@implementation DBFlatPickerView

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
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
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":view}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":view}]];
    
    self.data = [[NSArray alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.rowHeight = 60.f;
    self.paddingLeft = 0;
    self.paddingRight = 0;
}

#pragma mark - Public methods & setters

- (void)selectRow:(NSInteger)row {
    [tableView setContentOffset:CGPointMake(0.0, row * self.rowHeight)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    tableView.backgroundColor = backgroundColor;
}

-(void)setData:(NSArray<NSString *> *)data {
    _data = data;
    [tableView reloadData];
}

-(void)setSelectionColor:(UIColor *)selectionColor {
    _selectionColor = selectionColor;
    selectionOverlayView.backgroundColor = selectionColor;
}

-(void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    selectionHeightConstraint.constant = rowHeight;
}

-(void)reloadData {
    [tableView reloadData];
}

#pragma mark - UITableViewDelegate functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"FlatPickerViewCell";
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel *textLabel;
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.paddingLeft, 0.0, self.frame.size.width - self.paddingLeft - self.paddingRight, self.rowHeight)];
        textLabel.tag = CELL_LABEL_TAG;
        textLabel.text = self.data[indexPath.row];
        textLabel.backgroundColor = [UIColor clearColor];
        
        if([self.delegate respondsToSelector:@selector(labelStyleForFlatPickerView:forLabel:)]){
            [self.delegate labelStyleForFlatPickerView:self forLabel:textLabel];
        }
        
        [cell.contentView addSubview:textLabel];
        
    } else {
        textLabel = (UILabel*)[cell.contentView viewWithTag:CELL_LABEL_TAG];
        textLabel.text = self.data[indexPath.row];
    }
    
    textLabel.frame = CGRectMake(self.paddingLeft,
                                 (indexPath.row == 0) ? selectionOverlayView.frame.origin.y : 0.0,
                                 self.frame.size.width - self.paddingLeft - self.paddingRight,
                                 self.rowHeight);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Top and bottom padding
    if (indexPath.row == 0) {
        return (selectionOverlayView.frame.origin.y + self.rowHeight);
        
    } else if (indexPath.row == self.data.count - 1) {
        return (selectionOverlayView.frame.origin.y + self.rowHeight);
    }
    return self.rowHeight;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // Scroll to next multiple of rowHeight
    CGFloat floatVal = targetContentOffset->y / self.rowHeight;
    NSInteger rounded = (NSInteger)(lround(floatVal));
    targetContentOffset->y = rounded * self.rowHeight;
    
    if([self.delegate respondsToSelector:@selector(flatPickerView:didSelectRow:)]){
        [self.delegate flatPickerView:self didSelectRow:rounded];
    }
}


@end
