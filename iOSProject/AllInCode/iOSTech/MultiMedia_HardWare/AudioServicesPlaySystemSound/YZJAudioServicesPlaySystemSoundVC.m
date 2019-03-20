//
//  YZJAudioServicesPlaySystemSoundVC.m
//  AllInCode
//
//  Created by yangzijiang on 2019/3/20.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJAudioServicesPlaySystemSoundVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreFoundation/CoreFoundation.h>

@interface YZJAudioServicesPlaySystemSoundVC ()
/// 系统音频ID，用来注册我们将要播放的声音
@property (assign, nonatomic) SystemSoundID soundID;
@end

@implementation YZJAudioServicesPlaySystemSoundVC
#pragma mark --- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordItem *item00 = [LMJWordItem itemWithTitle:@"播放系统音频" subTitle:nil];
    item00.itemOperation = ^(NSIndexPath *indexPath) {
        /*开始播放*/
        AudioServicesPlaySystemSound(self.soundID);
        CFRunLoopRun();
    };
    
    LMJWordItem *item01 = [LMJWordItem itemWithTitle:@"停止系统音频" subTitle:nil];
    item01.itemOperation = ^(NSIndexPath *indexPath) {
        
    };
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

static void SoundFinished(SystemSoundID soundID,void* sample){
    /*播放全部结束，因此释放所有资源 */
    AudioServicesDisposeSystemSoundID(sample);
    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (SystemSoundID)soundID{
    if (!_soundID) {
        /*系统音频ID，用来注册我们将要播放的声音*/
        SystemSoundID soundID;
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received3.caf"]];  // 系统音频在/System/Library/Audio/UISounds目录下，具体音频文件可参考[1]
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        if (err) {
            NSLog(@"Error occurred assigning system sound!");
            return -1;
        }
        /*添加音频结束时的回调*/
        AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished, (__bridge void * _Nullable)(url));
        _soundID = soundID;
    }
    return _soundID;
}


/**
 [1] AudioServicesPlaySystemSound https://www.cnblogs.com/ruzhuan/p/3176715.html
 */
@end
