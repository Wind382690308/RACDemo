//
//  HLAudioRecorder.h
//  lovek12
//
//  Created by MYKJ on 16/12/6.
//  Copyright © 2016年 MYKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol HLRecorderDelegate <NSObject>

- (void)recorderSuccess:(AVAudioRecorder *)recorder flag:(BOOL)flag;

@end

@interface HLAudioRecorder : NSObject

@property (nonatomic, weak) id<HLRecorderDelegate> delegate;

- (instancetype)initWithResource_id:(NSInteger)resource_id;

- (void)startRecord;

- (void)stopRecord;

- (void)pauseRecord;

- (void)reStartRecord;

@end
