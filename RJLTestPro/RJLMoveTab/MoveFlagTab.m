//
//  MoveFlagTab.m
//  RJLTestPro
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "MoveFlagTab.h"
#import "MTSingletonManager.h"
#import "MoveTabView.h"
#import "FixTabView.h"
@interface MoveFlagTab ()
@property (nonatomic, strong) FixTabView *myFixView;
@property (nonatomic, strong) MoveTabView *myView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *closeEditButton;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation MoveFlagTab

- (void)viewWillAppear:(BOOL)animated
{
	
	[MTSingletonManager shareInstance].displayGridTitleArray = [NSMutableArray arrayWithObjects:@"收银台",@"结算",@"分享", @"T+0", @"中心",@"D+1", @"商店",@"P2P", @"开通", @"充值", @"转账", @"扫码", @"记录" , @"快捷支付", @"明细", @"收款",@"更多", nil];
	
	[MTSingletonManager shareInstance].displayGridImageArray =
	[NSMutableArray arrayWithObjects:
	 @"more_icon_Transaction_flow",@"more_icon_cancle_deal", @"more_icon_Search",
	 @"more_icon_t0",@"more_icon_shouyin" ,@"more_icon_d1",
	 @"more_icon_Settlement",@"more_icon_Mall", @"more_icon_gift",
	 @"more_icon_licai",@"more_icon_-transfer",@"more_icon_Recharge" ,
	 @"more_icon_Transfer-" , @"more_icon_Credit-card-",@"more_icon_Manager",@"work-order",@"add_businesses", nil];
	
	[MTSingletonManager shareInstance].displayGridIDArray =
	[NSMutableArray arrayWithObjects:
	 @"1000",@"1001", @"1002",
	 @"1003",@"1004",@"1005" ,@"1006",
	 @"1007",@"1008", @"1009",
	 @"1010",@"1011",@"1012" ,
	 @"1013" , @"1014",@"1015",@"1016", nil];

	
	NSArray * titleArray = [[NSArray alloc]init];
	NSArray * imageArray = [[NSArray alloc]init];
	NSArray * idArray = [[NSArray alloc]init];
	titleArray = [[NSUserDefaults standardUserDefaults] objectForKey:DisplayHQTabTitle];
	imageArray = [[NSUserDefaults standardUserDefaults] objectForKey:DisplayHQTabImage];
	idArray = [[NSUserDefaults standardUserDefaults] objectForKey:DisplayHQTabID];
	
	NSArray * moretitleArray = [[NSArray alloc]init];
	NSArray * moreimageArray = [[NSArray alloc]init];
	NSArray * moreidArray = [[NSArray alloc]init];
	moretitleArray = [[NSUserDefaults standardUserDefaults] objectForKey:OtherHQTabTitle];
	moreimageArray = [[NSUserDefaults standardUserDefaults] objectForKey:OtherHQTabImage];
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	[MTSingletonManager shareInstance].displayGridTitleArray = [[NSMutableArray alloc]initWithArray:titleArray];
	[MTSingletonManager shareInstance].displayGridImageArray = [[NSMutableArray alloc]initWithArray:imageArray];
	[MTSingletonManager shareInstance].displayGridIDArray = [[NSMutableArray alloc]initWithArray:idArray];
	
	[MTSingletonManager shareInstance].otherGridTitleArray = [[NSMutableArray alloc]initWithArray:moretitleArray];
	[MTSingletonManager shareInstance].otherGridImageArray = [[NSMutableArray alloc]initWithArray:moreimageArray];
	[MTSingletonManager shareInstance].otherGridIDArray = [[NSMutableArray alloc]initWithArray:moreidArray];
	
	
}

- (void)viewDidAppear:(BOOL)animated
{
	_editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
	[_editButton setBackgroundColor:[UIColor orangeColor]];
	[_editButton setTitle:@"编辑" forState:UIControlStateNormal];
	[_editButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[_editButton addTarget:self action:@selector(editItemClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_editButton];
	
	_closeEditButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 100, 50)];
	[_closeEditButton setBackgroundColor:[UIColor grayColor]];
	[_closeEditButton setTitle:@"关闭" forState:UIControlStateNormal];
	[_closeEditButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[_closeEditButton addTarget:self action:@selector(closeeditItemClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_closeEditButton];
	
	
	_addButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 100, 50)];
	[_addButton setBackgroundColor:[UIColor brownColor]];
	[_addButton setTitle:@"添加" forState:UIControlStateNormal];
	[_addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[_addButton addTarget:self action:@selector(addItemClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_addButton];
	
	_myView = [[MoveTabView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
	__weak __typeof(self)weakSelf = self;
	[_myView setAddBlock:^(CustomGridButton * custom){
		[weakSelf.myFixView addFixGridItem:custom];
	}];
	[self.view addSubview:_myView];
	_myFixView = [[FixTabView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200)];
	[_myFixView setAddFixItemBlock:^(CustomGridButton * custom){
		[weakSelf.myView addGridItem:custom];
	}];
	[self.view addSubview:_myFixView];
}
- (IBAction)editItemClick:(id)sender
{
	[_myView refreshPageToEdit];
}

- (IBAction)closeeditItemClick:(id)sender
{
	[_myView closeEditState];
}

- (IBAction)addItemClick:(id)sender
{
//	CustomGridButton *gridItem = [[CustomGridButton alloc] initWithFrame:CGRectZero title:@"人家亮" normalImage:[UIImage imageNamed:@"app_item_bg"] highlightedImage:[UIImage imageNamed:@"app_item_bg"] gridId:1017 atIndex:_myView.gridListArray.count  isAddDelete:NO deleteIcon:[UIImage imageNamed:@"app_item_plus"]  withIconImage:@"asdf"];
//	gridItem.gridTitle = @"人家亮";
//	gridItem.gridImageString = @"asdf";
//	gridItem.gridId = 1017;
//	_myView.addBlock(gridItem);
}

- (void)viewWillDisappear:(BOOL)animated
{
	[_myView removeFromSuperview];
	_myView = nil;
	[_editButton removeFromSuperview];
	_editButton = nil;
	[_closeEditButton removeFromSuperview];
	_closeEditButton = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{

}
@end
