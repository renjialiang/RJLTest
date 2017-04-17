//
//  RJLTestViewController.m
//  RJLTestPro
//
//  Created by mini on 16/9/21.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLPageCollectionBar/NewPageTabber.h"
#import "RJLPageCollectionBar/RJLWheelPageView.h"
#import "RJLTestViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
@interface RJLTestViewController () < ABPeoplePickerNavigationControllerDelegate >
@property (nonatomic, strong) RJLWheelPageView *wheelPageView;
@property (nonatomic, strong) NewPageTabber *pageTab;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSString *lockString;
@property (nonatomic, strong) NSCondition *condition;
@end

@implementation RJLTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:self action:@selector(gotoAddressBook:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 200, 200, 200)];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];

    //    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    layout.itemSize = self.view.bounds.size;
    //    layout.minimumLineSpacing = 0;
    //    layout.minimumInteritemSpacing = 0;
    //    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    self.wheelPageView = [[RJLWheelPageView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    //    NSArray *pageView = @[ @"http://www.51ifind.com/index.php?c=index&a=download", @"http://www.51ifind.com/index.php?c=index&a=index" ];
    //    [self.wheelPageView setPageViewArray:pageView];
    //	_pageTab = [[NewPageTabber alloc]initWithFrame:self.view.bounds infoArray:nil];
    //    [self.view addSubview:_pageTab];

    //--通讯录练习
    //	ABAddressBookRef addressBooks = nil;
    //
    //	//判断是否在ios6.0版本以上
    //	if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){
    //		addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
    //		//获取通讯录权限
    //		dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //
    //		ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
    //
    //		dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //	}else{
    //		CFErrorRef* error=nil;
    //		addressBooks = ABAddressBookCreateWithOptions(NULL, error);
    //	}
    //--锁练习
    _lock = [[NSLock alloc] init];
	_condition = [[NSCondition alloc]init];
}

- (void)handleLock:(BOOL)bFlag
{
    if (bFlag)
    {
        [_lock lock];
    }
    else
    {
        [_lock unlock];
    }
}

- (void)handleCondition:(BOOL)bFlag
{
	if (bFlag)
	{
		[_condition lock];
	}
	else
	{
		[_condition unlock];
	}
}

- (BOOL)checkAddressBookAuthorizationStatus
{
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        return NO;
    }
    return YES;
}
- (void)getLockafdString
{
    [self handleLock:YES];
    self.lockString = @"lock";
    NSLog(@"%@", _lockString);
    [self handleLock:NO];
}

- (void)gotoAddressBook:(UIButton *)btn
{
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
	^{
      NSString *str = weakSelf.lockString;
      [weakSelf handleLock:YES];
      NSLog(@"%@", str);
      [weakSelf handleLock:NO];
    });
    [self performSelectorOnMainThread:@selector(getLockafdString) withObject:nil waitUntilDone:NO];
    //    [self handleLock:NO];

    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

    //	if ([self checkAddressBookAuthorizationStatus]) {
    //		ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    //		peoplePicker.peoplePickerDelegate = self;
    //		[self presentViewController:peoplePicker animated:YES completion:nil];
    //	}
}

//- (void)canReadAddressBookWithBlock
//

#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(nonnull ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonAddressProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef, identifier);
    CFStringRef value = ABMultiValueCopyLabelAtIndex(valuesRef, index);
    [self dismissViewControllerAnimated:YES completion:^{
      NSString *str = (__bridge NSString *)value;
      NSLog(@"%@", str);
    }];
}

@end

//iOS 4种方式
//	Pthreads
//	NSThread
//	GCD - [Block, Dispatch Queue, Dispatch Semaphore, Dispatch Group, Dispatch Source]
//	Operation && Operation Queues
#import <pthread.h>

@implementation ConcurrencyTest

- (void)codeSmaple
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      for (NSInteger index = 0; index < 10; index++)
      {
          dispatch_async(dispatch_get_main_queue(), ^{

                         });
      }
    });

    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    aQueue.maxConcurrentOperationCount = 1;
    for (NSInteger index = 0; index < 10; index++)
    {
        NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
          [[NSOperationQueue mainQueue] addOperationWithBlock:^{

          }];
        }];
        [aQueue addOperation:blockOp];
    }
}

- (IBAction)startBtnClick:(UIButton *)sender
{
    pthread_t thread;
    pthread_create(&thread, NULL, start, NULL);
}

void *start(void *data)
{
    NSLog(@"%@", [NSThread currentThread]);
    return NULL;
}

- (void)dealloc
{
}

@end
