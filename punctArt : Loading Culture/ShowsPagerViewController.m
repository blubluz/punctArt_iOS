//
//  ShowsPagerViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowsPagerViewController.h"
#import "GetCategoriesRequest.h"
#import "GetPlayRepresRequest.h"
#import "ShowsViewController.h"
@interface ShowsPagerViewController ()
@property(strong, nonatomic) NSArray<CategoryModel *> *categories;
@property(strong, nonatomic) UISegmentedControl *titleSegment;
@property (nonatomic) NSUInteger selectedIndex;
@end

@implementation ShowsPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    
    self.titleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Recente" , @"Populare"]];
    self.titleSegment.tintColor = [UIColor blackColor];
    [self.titleSegment addTarget:self
                          action:@selector(segmentChanged:)
                forControlEvents:UIControlEventValueChanged];
    self.titleSegment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.titleSegment;

    
    
    self.categories = [[NSArray alloc] init];
    [[HttpClient sharedHTTPClient] performRequest:[[GetCategoriesRequest alloc] init] WithResponse:^(BaseResponse *response, NSError *error) {
        GetCategoriesResponse *resp = (GetCategoriesResponse *)response;
        self.categories = resp.categories;
        [self reloadData];
    }];
    self.selectedIndex = 0;
}
-(void)segmentChanged:(id)sender{
    if(self.titleSegment.selectedSegmentIndex == 0)
        NSLog(@"Recente");
    else
        NSLog(@"Populare");
    ShowsViewController *showViewController = (ShowsViewController *)[self viewPager:self contentViewControllerForTabAtIndex:self.selectedIndex];
    showViewController.orderType = self.titleSegment.selectedSegmentIndex==0?@"date":@"rating";
    [showViewController loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDataSource


- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.categories.count;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc] init];
    if(_categories)
        label.text = self.categories[index].categoryName;
    //label.backgroundColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = [label.text boundingRectWithSize:CGSizeMake(200, 0)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9.0]}
                                           context:nil];
    [label setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:11.5]];
    [label setTextColor:[UIColor colorWithRed:207.0/255.0 green:207.0/255.0 blue:207.0/255.0 alpha:1]];
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    ShowsViewController *pageContent = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"];
    pageContent.category = self.categories[index];
    //    pageContent.collectionView.delegate = self;
    //    pageContent.collectionView.dataSource = self;
    return pageContent;
}
-(void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{
    self.selectedIndex = index;
}

#pragma mark - ViewPagerDelegate


- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionTabHeight:
            return 45.0;
        case ViewPagerOptionCenterCurrentTab:
            return NO;
        case ViewPagerOptionFixLatterTabsPositions:
            return NO;
        case ViewPagerOptionTabWidth:
            return [UIScreen mainScreen].bounds.size.width/self.categories.count;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color{
    switch(component) {
        case ViewPagerIndicator:
            return [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        default:
            return color;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
