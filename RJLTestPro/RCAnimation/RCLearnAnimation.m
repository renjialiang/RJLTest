//
//  RCLearnAnimation.m
//  RJLTestPro
//
//  Created by mini on 16/9/26.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "AFNetworking.h"
#import "RCLearnAnimation.h"
#import "UIView+RJLAdd.h"
#import "ifmChart.h"
#import "ifmChartBorderComponent.h"
#import "ifmChartBottomTimeComponent.h"
#import "ifmChartDynamicIndexComponent.h"
#import "ifmChartLeftScaleComponent.h"
#import "ifmChartLineComponent.h"
#import "ifmChartSuspensionComponent.h"
#import "ifmChartTopLegendComponent.h"
@interface RCLearnAnimation ()
@property (nonatomic, weak) IBOutlet UIView *layerView;
@property (nonatomic, strong) ifmChart *chart;
@end

@implementation RCLearnAnimation




- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
//	CGPoint position = self.view.layer.position;
//	self.view.layer setPosition:<#(CGPoint)#>
//	self.view.layer setPosition:c
	
	
	
	
	
//     Do any additional setup after loading the view.
//        chartData.paddingTop = 20;
//        chartData.paddingBottom = 20;
//        chartData.paddingLeft = 20;
//        chartData.paddingRight = 20;
//        chartData.borderHorCount = 4;
//        chartData.borderVerCount = 4;

//    ifmChartData *chartData = [[ifmChartData alloc] initWithConfigFile:@"121"];
//
//    self.chart = [[ifmChart alloc] initWithFrame:CGRectMake(0, 180, self.view.width, 200) chartData:chartData];
//    [self.chart setBackgroundColor:[UIColor whiteColor]];
//
//    ifmChartLeftScaleComponent *lC = [[ifmChartLeftScaleComponent alloc] init];
//    lC.drawType = draw_in_graph;
//    lC.countType = ScaleCountUpMidDwon;
//    [_chart setChartComponent:lC];
//
//    ifmChartBottomTimeComponent *bC = [[ifmChartBottomTimeComponent alloc] init];
//    bC.drawType = draw_in_bottom;
//    bC.countType = TimeCountLeftMidRight;
//    [_chart setChartComponent:bC];
//
//    ifmChartTopLegendComponent *tC = [[ifmChartTopLegendComponent alloc] init];
//    tC.drawType = draw_in_top;
//    [_chart setChartComponent:tC];
//
//    ifmChartBorderComponent *borC = [[ifmChartBorderComponent alloc] init];
//    borC.drawType = draw_in_graph;
//    borC.isDashedLine = YES;
//    borC.frameColor = [UIColor orangeColor];
//    [_chart setChartComponent:borC];
//
//    ifmChartLineComponent *lineC = [[ifmChartLineComponent alloc] init];
//    lineC.drawType = draw_in_graph;
//    [_chart setChartComponent:lineC];
//
//    ifmChartSuspensionComponent *suC = [[ifmChartSuspensionComponent alloc] initSusType:SuspensionShuPingType curveType:CurveSuspensionSiMuNetValue];
//    suC.drawType = draw_in_graph;
//    [_chart setChartComponent:suC];
//
//    ifmChartDynamicIndexComponent *diC = [[ifmChartDynamicIndexComponent alloc] init];
//    diC.drawType = draw_in_graph;
//    [_chart setChartComponent:diC];
//
//    [self.view addSubview:self.chart];
}



- (void)viewDidAppear:(BOOL)animated
{
	CALayer *blueLayer = [CALayer layer];
	blueLayer.frame = CGRectMake(50.f, 50.f, 100.f, 100.f);
	blueLayer.backgroundColor = [UIColor blueColor].CGColor;
	UIImage *bgImage = [UIImage imageNamed:@"more_icon_Search"];
	self.layerView.layer.contents = (__bridge id _Nullable)bgImage.CGImage;
	//    self.layerView.layer.contentsGravity = kCAGravityResizeAspectFill;
	self.layerView.layer.contentsScale = bgImage.scale;
	//    self.layerView.layer.masksToBounds = YES;
	//	[self.layerView.layer setContentsRect:CGRectMake(0, 0, 0.5, 0.5)];
	self.layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
	[self.layerView.layer addSublayer:blueLayer];
	
	UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
	
	
	
	CABasicAnimation *anmination = [CABasicAnimation animationWithKeyPath:@"position.y"];
	anmination.repeatCount = 1;
	anmination.fromValue = @(10);
	anmination.toValue =  @(200);
	anmination.duration = 0.5;
	anmination.removedOnCompletion = NO;
	anmination.fillMode = kCAFillModeForwards;
	anmination.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	[blueLayer addAnimation:anmination forKey:@"animataion"];
	
//    __weak __typeof(self) weakSelf = self;
//    NSURL *url = [NSURL URLWithString:@"http://gz.fund.10jqka.com.cn/?module=api&controller=index&action=chart&info=vm_fd_JSM107&start=0930"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.timeoutInterval = 10.0;
//    NSOperationQueue *oq = [NSOperationQueue currentQueue];
//    [NSURLConnection sendAsynchronousRequest:request queue:oq completionHandler:^(NSURLResponse *_Nullable response, NSData *_Nullable data, NSError *_Nullable connectionError) {
//      if (response)
//      {
//          NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//          NSArray *dataArray = [dataString componentsSeparatedByString:@";"];
//          NSMutableArray *initArray = [[NSMutableArray alloc] initWithArray:dataArray];
//          [initArray removeObjectAtIndex:0];
//          NSString *firstContent = [initArray objectAtIndex:0];
//          if ([firstContent rangeOfString:@"~"].location != NSNotFound)
//          {
//              NSArray *contentArray = [firstContent componentsSeparatedByString:@"~"];
//              [initArray replaceObjectAtIndex:0 withObject:[contentArray lastObject]];
//          }
//          NSMutableArray *valuationDataArray = [[NSMutableArray alloc] initWithCapacity:initArray.count];
//          NSMutableArray *yesterdayDataArray = [[NSMutableArray alloc] initWithCapacity:initArray.count];
//
//          NSMutableArray *timeDataArray = [[NSMutableArray alloc] initWithCapacity:initArray.count];
//
//          for (NSInteger index = 0; index < initArray.count; index++)
//          {
//              NSString *str = [initArray objectAtIndex:index];
//              NSArray *strArray = [str componentsSeparatedByString:@","];
//              if (strArray.count == 4)
//              {
//                  [timeDataArray addObject:[strArray objectAtIndex:0]];
//                  [valuationDataArray addObject:[strArray objectAtIndex:1]];
//                  [yesterdayDataArray addObject:[strArray objectAtIndex:2]];
//              }
//          }
//          NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
//          [dic setObject:valuationDataArray forKey:CURVEDATA];
//          [dic setObject:timeDataArray forKey:@"timeArray"];
//          [dic setObject:timeDataArray forKey:@"yesterdayArray"];
//          [self.chart setChartCurveData:dic];
//          NSLog(@"%@", valuationDataArray);
//      }
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
