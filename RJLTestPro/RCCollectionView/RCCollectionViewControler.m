//
//  RCCollectionViewControler.m
//  RJLTestPro
//
//  Created by mini on 2016/12/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RCCollectionViewControler.h"
#import "RJLFPSLabel.h"
#import "UIView+RJLAdd.h"

@interface RCCollectionViewControler ()
@property (nonatomic, strong) RJLFPSLabel *fpsLabel;
@end

@implementation RCCollectionViewControler

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	((RCCollectionViewFlowLayout *)self.collectionViewLayout).columnCount = 3;
	((RCCollectionViewFlowLayout *)self.collectionViewLayout).columnMargin = 10;
	((RCCollectionViewFlowLayout *)self.collectionViewLayout).rowMargin = 10;
	((RCCollectionViewFlowLayout *)self.collectionViewLayout).edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
	((RCCollectionViewFlowLayout *)self.collectionViewLayout).columnHeights = [[NSMutableArray alloc]init];
	((RCCollectionViewFlowLayout *)self.collectionViewLayout).attrsArray = [[NSMutableArray alloc]init];
	_fpsLabel = [RJLFPSLabel new];
	[_fpsLabel sizeToFit];
	[_fpsLabel setBackgroundColor:[UIColor redColor]];
	_fpsLabel.top = 0;
	_fpsLabel.left = 10;
	_fpsLabel.alpha = 1;
	[self.view addSubview:_fpsLabel];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	NSLog(@"%@",cell);
	[cell setBackgroundColor:[UIColor colorWithRed:(arc4random() % 256) / 255.0 green:(arc4random() % 256) / 255.0 blue:(arc4random() % 256) / 255.0 alpha:1.0]];    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
