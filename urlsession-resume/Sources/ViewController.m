//
//  ViewController.m
//  urlsession-resume
//
//  Created by Samuel Défago on 09.01.17.
//  Copyright © 2017 Samuel Défago. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, weak) IBOutlet UILabel *progressLabel;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"ch.defagos.urlsession-bug"];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressLabel.text = [NSString stringWithFormat:@"Completion: %.2f%%", (double)totalBytesWritten / totalBytesExpectedToWrite * 100.];
    });
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSData *resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
    if (resumeData) {
        self.downloadTask = [self.session downloadTaskWithResumeData:resumeData];
    }
    else if (! error) {
        NSString *tempFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"debian.ios.temp"];
        [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:NULL];
    }
}

- (IBAction)start:(id)sender
{
    NSString *tempFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"debian.ios.temp"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:tempFilePath]) {
        NSData *resumeData = [NSData dataWithContentsOfFile:tempFilePath];
        self.downloadTask = [self.session downloadTaskWithResumeData:resumeData];
    }
    else {
        NSURL *URL = [NSURL URLWithString:@"http://cdimage.debian.org/debian-cd/8.6.0/amd64/iso-cd/debian-8.6.0-amd64-netinst.iso"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        self.downloadTask = [self.session downloadTaskWithRequest:request];
    }
    [self.downloadTask resume];
}

- (IBAction)pause:(id)sender
{
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        if (! resumeData) {
            return;
        }
        
        NSString *tempFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"debian.ios.temp"];
        [resumeData writeToFile:tempFilePath atomically:YES];
    }];
}

@end
