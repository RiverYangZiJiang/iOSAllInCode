//
//  YZJAVAudioPlayer.m
//  AllInCode
//
//  Created by 杨子江 on 3/19/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface YZJAVAudioPlayer ()
@property (strong, nonatomic) AVAudioPlayer *player;
@end
@implementation YZJAVAudioPlayer
- (void)viewDidLoad{
    [super viewDidLoad];
    
    LMJWordItem *item00 = [LMJWordItem itemWithTitle:@"播放系统音频" subTitle:nil];
    item00.itemOperation = ^(NSIndexPath *indexPath) {
        [self.player prepareToPlay];
        [self.player play];
    };
    
    LMJWordItem *item01 = [LMJWordItem itemWithTitle:@"停止系统音频" subTitle:nil];
    item01.itemOperation = ^(NSIndexPath *indexPath) {
        [self.player stop];
    };
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

- (AVAudioPlayer *)player{
    if (!_player) {
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received3.caf"]];  // 系统音频在/System/Library/Audio/UISounds目录下，具体音频文件可参考[1]
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _player.numberOfLoops = 5;  // 循环次数
    }
    return _player;
}


/**
 [1]http://iphonedevwiki.net/index.php/AudioServices
 [2]https://www.jianshu.com/p/e5dbd92871a4
 */
@end
