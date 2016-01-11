//
//  DownloadViewController.m
//  HttpDownloadProgress
//
//  Created by apple on 8/15/15.
//  Copyright (c) 2015 jackyshan. All rights reserved.
//

#import "DownloadViewController.h"

static MKNetworkEngine *engine = nil;

@implementation DownloadViewController

- (void)viewDidLoad {
    self.title = @"下载";
    
    CircularProgressButton *progressBtn = [[CircularProgressButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)
                                                                         backGressColor:[UIColor grayColor]
                                                                          progressColor:[UIColor greenColor]
                                                                              lineWidth:5.f];
    progressBtn.center = self.view.center;
    [progressBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [progressBtn setTitle:[NSString stringWithFormat:@"%.f%%", 0.0 * 100] forState:UIControlStateNormal];
    progressBtn.selected = NO;
    [self.view addSubview:progressBtn];
    self.progressBtn = progressBtn;

    [progressBtn addTarget:self action:@selector(_downloadAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_downloadAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self _download];
    }
    else {
        [self _cancelDownlaod];
    }
}

- (void)_download {
    if (!engine) {
        engine = [[MKNetworkEngine alloc] init];
    }
    
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:@"http://dldir1.qq.com/qqfile/qq/QQ8.0/16968/QQ8.0.exe" params:nil httpMethod:@"Get"];
    [operation addHeader:@"Range" withValue:[NSString stringWithFormat:@"bytes=%llu-", [self _getCacheFileSize:[self _savePath]]]];
    [operation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:[self _savePath] append:YES]];
    __weak __typeof(self) weakSelf = self;
    [operation onDownloadProgressChanged:^(double progress) {
        NSLog(@"%.2f", progress);
        
        [weakSelf.progressBtn setTitle:[NSString stringWithFormat:@"%.f%%", progress * 100] forState:UIControlStateNormal];
        [weakSelf.progressBtn setProgress:progress];
        if (progress == 1) {
            weakSelf.progressBtn.userInteractionEnabled = NO;
        }
    }];
    self.operation = operation;
    
    [engine enqueueOperation:operation];
    
}

- (void)_cancelDownlaod {
    [self.operation cancel];
}

- (NSString *)_savePath {
    NSString *savePath = [NSTemporaryDirectory() stringByAppendingString:@"p1469094_128k.mp4"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:savePath]) {
        BOOL res = [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
        
		if (res) {
			NSLog(@"创建成功: %@", savePath);
		}
		else {
			NSLog(@"savepath 创建失败");
		}
    };
    
    return savePath;
    
}

- (unsigned long long)_getCacheFileSize:(NSString *)tempFilePath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	if ([fileManager fileExistsAtPath:tempFilePath]) {
		unsigned long long fileSize = [[fileManager attributesOfItemAtPath:tempFilePath
		                                                             error:nil]
		                               fileSize];
		return fileSize;
	}
    
	return 0;
}

@end
