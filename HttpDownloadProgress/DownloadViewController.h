//
//  DownloadViewController.h
//  HttpDownloadProgress
//
//  Created by apple on 8/15/15.
//  Copyright (c) 2015 jackyshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressButton.h"
#import "MKNetworkKit.h"

@interface DownloadViewController : UIViewController

@property (nonatomic, strong) CircularProgressButton *progressBtn;
@property (nonatomic, strong) MKNetworkOperation *operation;

@end
