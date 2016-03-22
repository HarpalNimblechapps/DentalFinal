//
//  KLHorizontalSelect.m
//  KLHorizontalSelect
//
//



#import "KLHorizontalSelect.h"
#import <QuartzCore/QuartzCore.h>
//#import "CurrencyConverterFinal-Swift.h"



@interface KLHorizontalSelect ()
-(CGFloat) defaultMargin;
@end
@implementation KLHorizontalSelect
-(CGFloat) defaultMargin {
    
    return self.frame.size.width/2.0 - kDefaultCellWidth/2.0;
}
-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder: aDecoder]) {
        [self initialize];
    }
    return self;
}
-(id) initWithFrame:(CGRect)frame delegate:(id<KLHorizontalSelectDelegate>) delegate {
    if (self = [self initWithFrame: frame]) {
        [self.layer setCornerRadius:5.0];
        _delegate = delegate;
    }
    return  self;
}
-(void) initialize {
    //Configure the arrow
//    self.arrow = [[KLHorizontalSelectArrow alloc] initWithFrame:CGRectMake(0, kDefaultCellHeight, kHeaderArrowWidth, kHeaderArrowHeight)color:[UIColor clearColor]];
//    [self.arrow setCenter:CGPointMake(self.frame.size.width/2.0, kDefaultCellHeight)];
    
    
    
    self.arrow = [[KLHorizontalSelectArrow alloc] initWithFrame:CGRectMake(0, kDefaultCellHeight, kHeaderArrowWidth, kHeaderArrowHeight)color:[UIColor clearColor]];
    [self.arrow setCenter:CGPointMake(self.frame.size.width/2.0, -6.0)];
    
    ///[self addSubview:self.arrow];
    [self.arrow hide:YES];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.height, self.frame.size.width)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    [self.tableView setCenter: self.center];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.tableView setContentInset: UIEdgeInsetsMake(self.defaultMargin, 0, self.defaultMargin, 0)];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setDecelerationRate: UIScrollViewDecelerationRateFast];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview: self.tableView];
    
    
//    [self.layer setShadowColor: [kDefaultShadowColor CGColor]];
//    [self.layer setShadowOffset: kDefaultShadowOffset];
//    [self.layer setShadowOpacity: kDefaultShadowOpacity];

    self.backgroundColor = [UIColor clearColor];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
-(void) setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kDefaultCellHeight)];
}
-(void) drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    // Draw gradient
//    CGGradientRef myGradient;
//    CGColorSpaceRef myColorspace;
//    size_t num_locations = 2;
//    CGFloat locations[2] = { 0.0, 1.0 };
//    
//    CGFloat topRed = 0.0, topGreen = 0.0, topBlue = 0.0, topAlpha =0.0;
//    [kDefaultGradientTopColor getRed:&topRed green:&topGreen blue:&topBlue alpha:&topAlpha];
//    
//    CGFloat bottomRed = 0.0, bottomGreen = 0.0, bottomBlue = 0.0, bottomAlpha =0.0;
//    [kDefaultGradientBottomColor getRed:&bottomRed green:&bottomGreen blue:&bottomBlue alpha:&bottomAlpha];
//    
//    CGFloat components[8] = { topRed, topGreen, topBlue, topAlpha,  // Start color
//        bottomRed, bottomGreen, bottomBlue, bottomAlpha}; // End color
//    
//    myColorspace = CGColorSpaceCreateDeviceRGB();
//    
//    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
//                                                      locations, num_locations);
//    CGColorSpaceRelease(myColorspace);
//    CGPoint myStartPoint, myEndPoint;
//    myStartPoint.x = self.frame.size.width/2;
//    myStartPoint.y = 0.0;
//    myEndPoint.x = self.frame.size.width/2;
//    myEndPoint.y = self.frame.size.height;
//    CGContextDrawLinearGradient (context, myGradient, myStartPoint, myEndPoint, 0);
//    CGGradientRelease(myGradient);
    
}
#pragma mark - UIScrollViewDelegate implementation

-(void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.arrow show:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging) {
        [self.arrow hide:YES];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidFinishScrolling:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate) {
        [self scrollViewDidFinishScrolling:scrollView];
    }
    
}

-(void) scrollViewDidFinishScrolling: (UIScrollView*) scrollView {
    CGPoint point = [self convertPoint:CGPointMake(self.frame.size.width/2.0, kDefaultCellHeight/2.0) toView:self.tableView];
    NSIndexPath* centerIndexPath = [self.tableView indexPathForRowAtPoint:point];
    
    [self.tableView selectRowAtIndexPath: centerIndexPath
                                animated: YES
                          scrollPosition: UITableViewScrollPositionTop];
    
    if (centerIndexPath.row != self.currentIndex.row) {
        
        [self setCurrentIndex:centerIndexPath];
    }
    [self.arrow show:YES];
    
}
-(void) setCurrentIndex:(NSIndexPath *)currentIndex {
    
    self->_currentIndex = currentIndex;
    [self.arrow hide:YES];
    [self.tableView scrollToRowAtIndexPath:currentIndex
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(horizontalSelect:didSelectCell:)]) {
        if(currentIndex != nil){
        [self.delegate horizontalSelect:self didSelectCell:(KLHorizontalSelectCell*)[self.tableView cellForRowAtIndexPath:currentIndex]];
        }
    }
}
#pragma mark - UITableViewDelegate implementation
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != self.currentIndex.row ) {
        //Hide the arrow when scrolling
        [self setCurrentIndex:indexPath];
    }
    
    
}
#pragma mark - UITableViewDataSource implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Add an blank cell with spacing for
    return 32;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString* reuseIdentifier = @"HorizontalCell";
    KLHorizontalSelectCell* cell = (KLHorizontalSelectCell*)[self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(cell == nil) {
        cell = [[KLHorizontalSelectCell alloc] init];
    }
    [cell.label setTag:indexPath.row];
    [cell.label setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell.label setText:[NSString stringWithFormat:@"%@",[self.tableData objectAtIndex:indexPath.row]]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultCellWidth;
}

@end

@implementation KLHorizontalSelectCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIView* containingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultCellHeight, kDefaultCellWidth)];
        [containingView setBackgroundColor:[UIColor clearColor]];

        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, containingView.frame.size.width, kDefaultLabelHeight)];
        [self.label setTextAlignment:NSTextAlignmentCenter];
        [self.label setCenter: CGPointMake(containingView.frame.size.width/2.0, 50)];
        //[self.label setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1]];
        [self.label setBackgroundColor:[UIColor clearColor]];
        [self.label setFont: [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:23.0]];
        [self.label setTextColor:[UIColor darkGrayColor]];
        [containingView addSubview: self.label];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        [containingView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:containingView];
    }
    return self;
}
@end

@implementation KLHorizontalSelectArrow
- (float) hypotenuse {
    return (CGFloat)self.frame.size.width / sqrt(2.0);
}
-(id) initWithFrame:(CGRect)frame color:(UIColor*) color {
    if (self = [super initWithFrame:frame]) {
        self.isShowing = YES;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path,NULL,0.0,0.0);
        CGPathAddLineToPoint(path, NULL, 0.0f, 0.0f);
        CGPathAddLineToPoint(path, NULL, frame.size.width, 0.0f);
        //CGPathAddLineToPoint(path, NULL, frame.size.width/2.0, frame.size.height);
        CGPathAddLineToPoint(path, NULL, frame.size.width/2.0, frame.size.height);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setPath:path];
        //[shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        
        [self.layer addSublayer:shapeLayer];
        CGPathRelease(path);
        [self setAnchorPoint:CGPointMake(0.5, 0.0) forView:self];
        
    }
    return self;
}
-(void) show:(BOOL) animated {
    if (!self.isShowing) {
        if (animated) {
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.layer setTransform: CATransform3DRotate(self.layer.transform, -(1/4.0)*M_PI, 1.0, 0.0, 0.0)];
            }];
        }
        {
            [self.layer setTransform: CATransform3DRotate(self.layer.transform,-(1/4.0)*M_PI, 1.0, 0.0, 0.0)];
        }
    }
    
    self.isShowing = YES;
}


-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}
-(void) hide:(BOOL) animated {
    if (self.isShowing) {
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.layer setTransform: CATransform3DRotate(self.layer.transform, (1/4.0)*M_PI,1.0, 0.0, 0.0)];
            }];
        }
        {
            [self.layer setTransform: CATransform3DRotate(self.layer.transform, (1/4.0)*M_PI, 1.0, 0.0, 0.0)];
        }
    }
    self.isShowing = NO;
}

-(void) toggle:(BOOL) animated {
    if (self.isShowing) {
        [self hide:animated];
    }
    else {
        [self show:animated];
    }
}
@end
