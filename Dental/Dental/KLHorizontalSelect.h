//
//  KLHorizontalSelect.h
//  KLHorizontalSelect
//
//

//Control Properties
#define kDefaultCellWidth 100      //The width of each of the items
#define kDefaultCellHeight 50       //Height of the items/control
//#define kDefaultGradientTopColor  [UIColor colorWithRed: 27/255.0 green: 171/255.0 blue: 204/255.0 alpha: 0]  //Top Gradient Color
//#define kDefaultGradientBottomColor   [UIColor colorWithRed: 27/255.0 green: 171/255.0 blue: 204/255.0 alpha: 0]  //Top Gradient Color

#define kDefaultGradientTopColor  [UIColor colorWithRed: 27/255.0 green: 171/255.0 blue: 204/255.0 alpha: 1]  //Top Gradient Color
#define kDefaultGradientBottomColor   [UIColor colorWithRed: 27/255.0 green: 171/255.0 blue: 204/255.0 alpha: 1]  //Top Gradient Color
#define kDefaultLabelHeight 50.0   //Adjusts the height of the label
#define kDefaultImageHeight 50.0    //Adjusts the height of the image

//Arrow properties
#define kHeaderArrowWidth 10.0      //Adjusts the width of the selection arrow
#define kHeaderArrowHeight 6.0     //Adjusts the width of the selection arrow

//Shadow properties
#define kDefaultShadowColor [UIColor clearColor]
#define kDefaultShadowOffset CGSizeMake(0.0,0.0)
#define kDefaultShadowOpacity 0.0

#import <UIKit/UIKit.h>

@interface KLHorizontalSelectCell : UITableViewCell
@property (nonatomic, strong) UILabel* label;
@property (nonatomic)  int containerHeight;
@end


@interface KLHorizontalSelectArrow : UIView
@property (nonatomic) BOOL isShowing;
-(void) show:(BOOL) animated;
-(void) hide:(BOOL) animated;
-(void) toggle:(BOOL) animated;
-(id) initWithFrame:(CGRect)frame color:(UIColor*) color;
@end

@protocol KLHorizontalSelectDelegate <NSObject>
@optional
-(void) horizontalSelect:(id)horizontalSelect didSelectCell:(KLHorizontalSelectCell*) cell;
@end

@interface KLHorizontalSelect : UIView <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSIndexPath* currentIndex;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* tableData;
@property (nonatomic, strong) KLHorizontalSelectArrow* arrow;
@property (nonatomic, weak) IBOutlet id<KLHorizontalSelectDelegate> delegate;

-(id) initWithFrame:(CGRect)frame delegate:(id<KLHorizontalSelectDelegate>) delegate;

@end


