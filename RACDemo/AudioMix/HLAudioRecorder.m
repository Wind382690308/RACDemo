//
//  HLAudioRecorder.m
//  lovek12
//
//  Created by MYKJ on 16/12/6.
//  Copyright © 2016年 MYKJ. All rights reserved.
//

#import "HLAudioRecorder.h"
//#import <HLBaseLibraries/HLBaseLibraries.h>

@interface HLAudioRecorder ()<AVAudioRecorderDelegate>

@property (nonatomic, assign) NSInteger r_id;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HLAudioRecorder

- (instancetype)initWithResource_id:(NSInteger)resource_id {
    self = [super init];
    if (self) {
        self.r_id = resource_id;
        [self setAudioSession];
    }
    return self;
}

#pragma mark - public methods

- (void)startRecord {
    if (!self.recorder.isRecording) {
        [self.recorder record];
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (void)stopRecord {
    [self.recorder stop];
    self.timer.fireDate = [NSDate distantFuture];

}

- (void)pauseRecord {
    if (self.recorder.isRecording) {
        [self.recorder pause];
        self.timer.fireDate = [NSDate distantFuture];

    }
}

- (void)reStartRecord {
    [self.recorder deleteRecording];
    [self.recorder stop];
    [self.recorder recordAtTime:0];
    self.timer.fireDate = [NSDate distantFuture];

}

#pragma mark - private methods

- (void)setAudioSession {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

- (NSURL *)getSavePath {

    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/VODDownloads/Recording/%ld/temp/",NSHomeDirectory(),self.r_id];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    if (!HLFileExistsAtURL(fileURL, YES)) {
        HLFileCreateAtURL(fileURL, YES);
    }
//    NSString *exp = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).lastObject;
    NSString *exportFile = [NSString stringWithFormat:@"%@/Documents/VODDownloads/Recording/%ld/temp/recording.caf",NSHomeDirectory(),self.r_id];
    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
    if (HLFileExistsAtURL(exportURL, NO)) {
        HLFileRemoveAtURL(exportURL, NO);
    }
    return exportURL;
}

- (NSDictionary *)getAudioSetting {
    return @{AVFormatIDKey: [NSNumber numberWithUnsignedInteger:kAudioFormatAppleIMA4],
          AVSampleRateKey: @(22050),
    AVNumberOfChannelsKey: @(1),
   AVLinearPCMBitDepthKey: @(8),
    AVLinearPCMIsFloatKey: @(YES)};
}

- (void)audioPowerChange {
    [self.recorder updateMeters];
}

#pragma mark - AudioDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if ([self.delegate respondsToSelector:@selector(recorderSuccess:flag:)]) {
        [self.delegate recorderSuccess:recorder flag:flag];
    }
}

#pragma mark - getter methods 

- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        _recorder = [[AVAudioRecorder alloc] initWithURL:[self getSavePath] settings:[self getAudioSetting] error:nil];
        _recorder.meteringEnabled = YES;
        _recorder.delegate = self;
    }
    return _recorder;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
