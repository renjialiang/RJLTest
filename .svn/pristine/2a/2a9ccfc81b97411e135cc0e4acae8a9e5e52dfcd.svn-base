//
//  RJLAdvertisementSrollView.m
//  RJLTestPro
//
//  Created by mini on 16/5/17.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLAdvertisementSrollView.h"
#define PageControllWidth			100
#define PageControllHeight			18
#define ImageView_TAG				1000

@interface RJLAdvertisementSrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) NSTimer				*timer;
@property (nonatomic, assign) NSTimeInterval		timeInterVal;
@property (nonatomic, assign) SubType				inputDataType;
@property (nonatomic, assign) AutoScrollStrategy	scrollDirection;
@property (nonatomic, strong) UIScrollView			*scrollView;
@property (nonatomic, strong) UIPageControl			*pageControl;
@property (nonatomic, strong) NSMutableArray		*slideImages;
@property (nonatomic, copy)	NSArray					*urlStrings;
@property (nonatomic) BOOL							isAutoSetHeightWithImage;
@end

@implementation RJLAdvertisementSrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc
{
	if (_scrollView) {
		[_scrollView removeFromSuperview];
		_scrollView = nil;
	}
	if (_pageControl) {
		[_pageControl removeFromSuperview];
		_pageControl = nil;
	}
	if (_slideImages) {
		[_slideImages removeAllObjects];
		_slideImages = nil;
	}
	if (_urlStrings) {
		_urlStrings = nil;
	}
	_timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame timeInterval:(NSTimeInterval)timeInterVal subViewArray:(NSArray *)viewArray dataArray:(NSArray *)dataArray exParam:(NSDictionary *)dicParam
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initControl:frame timeInterval:timeInterVal subViewArray:viewArray dataArray:dataArray exParam:dicParam];
	}
	return self;
}

- (void)initControl:(CGRect)frame timeInterval:(NSTimeInterval)timeInterVal subViewArray:(NSArray *)viewArray dataArray:(NSArray *)dataArray exParam:(NSDictionary *)dicParam
{
	if (!viewArray || viewArray.count == 0) {
		return;
	}
	_slideImages = [[NSMutableArray alloc] initWithArray:viewArray];
	if (dataArray && dataArray.count > 0) {
		_urlStrings = dataArray;
	}
	
	if (self.timer) {
		[self.timer invalidate];
		self.timer = nil;
	}
	self.timer =  [NSTimer scheduledTimerWithTimeInterval:timeInterVal target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
	self.timeInterVal = timeInterVal;
	
	while (self.subviews.count) {
		UIView *view = [self.subviews firstObject];
		[view removeFromSuperview];
	}
	if (dicParam && dicParam.count > 0) {
		[self handleParamEx:dicParam];
	}
	else {
		_inputDataType = type_urlimage;
		_scrollDirection = leftToright;
	}
	[self initScrollViewAndPageControl];
	[self rankTheImageQueue];
}

#pragma mark - Private Method
- (void)handleParamEx:(NSDictionary *)dicEx
{
	for (NSString *key in dicEx)
	{
		if ([key isEqualToString:InputSubViewType]) {
			self.inputDataType = [[dicEx objectForKey:InputSubViewType] integerValue];
		}
		if ([key isEqualToString:UIViewScrollStrategy]) {
			self.scrollDirection = [[dicEx objectForKey:UIViewScrollStrategy] integerValue];
		}
		if ([key isEqualToString:SelfAutoLayoutWithImage]) {
			self.isAutoSetHeightWithImage = [[dicEx objectForKey:SelfAutoLayoutWithImage] boolValue];
		}
	}
}

- (void)initScrollViewAndPageControl
{
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	_scrollView.bounces = YES;
	_scrollView.pagingEnabled = YES;
	_scrollView.delegate = self;
	_scrollView.userInteractionEnabled = YES;
	_scrollView.showsHorizontalScrollIndicator = NO;
	[self addSubview:_scrollView];
	_scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	
	_pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.origin.x + self.frame.size.width / 2 - PageControllWidth / 2,self.frame.size.height - PageControllHeight, PageControllWidth, PageControllHeight)];
	[_pageControl setCurrentPageIndicatorTintColor:[UIColor yellowColor]];
	[_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
	_pageControl.numberOfPages = [self.slideImages count];
	_pageControl.currentPage = 0;
	[_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
	_pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self addSubview:_pageControl];
}


/**
 *  首页是第0页，默认从第1页开始的
 *	取数组最后一张图片 放在第0页
 *	原理：4-[1-2-3-4]-1
 */
- (void)rankTheImageQueue
{
	if (!self.slideImages) {
		return;
	}
	if (_isAutoSetHeightWithImage) {
		UIView *imageView = [self setImageviewWithViewType:self.inputDataType index:0];
		if (imageView.frame.size.height > self.frame.size.height) {
			[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, imageView.frame.size.height)];
		}
	}
	
	for (NSUInteger i = 0; i < [_slideImages count]; i++)
	{
		UIView *imageView = [self setImageviewWithViewType:self.inputDataType index:i];
		imageView.frame = CGRectMake((self.frame.size.width * i) + self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
		imageView.tag = ImageView_TAG + i;
		imageView.userInteractionEnabled = YES;
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToUrl:)];
		[imageView addGestureRecognizer:tapGesture];
		imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		[_scrollView addSubview:imageView];
	}
	
	UIView *imageView = [self setImageviewWithViewType:self.inputDataType index:[_slideImages count] - 1];
	imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	[_scrollView addSubview:imageView];
	imageView = [self setImageviewWithViewType:self.inputDataType index:0];
	imageView.frame = CGRectMake((self.frame.size.width * ([_slideImages count] + 1)) , 0, self.frame.size.width, self.frame.size.height);
	[_scrollView addSubview:imageView];
	
	[_scrollView setContentSize:CGSizeMake(self.frame.size.width * ([_slideImages count] + 2), self.frame.size.height)];
	[_scrollView setContentOffset:CGPointMake(0, 0)];
	[self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
	if (_slideImages.count == 1) {
		[self.timer invalidate];
		self.scrollView.scrollEnabled = NO;
		self.pageControl.hidden = YES;
	}
	else {
		self.scrollView.scrollEnabled = YES;
		self.pageControl.hidden = NO;
	}
}

- (UIView *)setImageviewWithViewType:(SubType)type index:(NSUInteger)num
{
	UIImageView *imageview;
	switch (type) {
		case type_urlimage:
			imageview = [[UIImageView alloc]init];
//			[imageview sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:num]]];
			break;
		case type_imageName:
			imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:num]]];
			break;
		case type_customview:
			imageview = _slideImages[num];
			break;
		case type_localimage:
			imageview = [[UIImageView alloc]initWithImage:[_slideImages objectAtIndex:num]];
			break;
		default:
			break;
	}
	return imageview;
}

#pragma mark - IBAction
- (void)runTimePage
{
	NSInteger page = _pageControl.currentPage;
	page++;
	page = page > ([_slideImages count] -1) ? 0 : page ;
	_pageControl.currentPage = page;
	[self turnPage];
}

- (void)turnPage
{
	NSInteger page = _pageControl.currentPage;
	[UIView animateWithDuration:0.5 animations:^{
		if (page == 0) {//当page等于0的时候先让页面跳转到最后一页
			[_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*([_slideImages count] + 1),0,self.frame.size.width,self.frame.size.height) animated:YES];
		}
		else {
			[_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*(page+1),0,self.frame.size.width,self.frame.size.height) animated:YES];
		}
	} completion:^(BOOL finished) {
		if (page == 0) {//当page等于0的时候，现在页面在最后一页，还原到对应的第一页
			double delayinseconds = 0.5;
			dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayinseconds * NSEC_PER_SEC);
			dispatch_after(time, dispatch_get_main_queue(), ^{
				[_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];
			});
		}
	}];
}

- (void)jumpToUrl:(UITapGestureRecognizer *)recongnizer
{
	if (_svDelegate && [_svDelegate respondsToSelector:@selector(didSelectedViewWithData:)]) {
		if (_urlStrings &&_urlStrings.count > 0) {
			[_svDelegate didSelectedViewWithData:self.urlStrings[recongnizer.view.tag - ImageView_TAG]];
		}
	}
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[_timer invalidate];
	_timer = nil;
	_timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterVal target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
	CGFloat pagewidth = self.scrollView.frame.size.width;
	int currentPage = floor((_scrollView.contentOffset.x - pagewidth/ ([_slideImages count]+2)) / pagewidth) + 1;
	if (currentPage==0)
	{
		[self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * [_slideImages count],0,self.frame.size.width,self.frame.size.height) animated:NO];
	}
	else if (currentPage==([_slideImages count]+1))
	{
		[self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];
	}
	int page = floor((self.scrollView.contentOffset.x - pagewidth/([_slideImages count]+2))/pagewidth)+1;
	page --;
	_pageControl.currentPage = page;
}
@end
