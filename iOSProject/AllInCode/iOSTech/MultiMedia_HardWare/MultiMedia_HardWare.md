# 总结

| 名称                         | 循环                                           | 音量键控制音量大小 | 震动  | 播放系统音频 | 本地音频 |      |
| :--------------------------- | ---------------------------------------------- | ------------------ | ----- | ------------ | -------- | ---- |
| AVAudioPlayer                | numberOfLoops                                  | √                  | false | true         | true     |      |
| AudioServicesPlaySystemSound | 只能在播放结束时再次递归调用播放，达到循环效果 | false              | true  | true         | true     |      |
|                              |                                                |                    |       |              |          |      |

# AVAudioPlayer

AVAudioPlayer 是一个属于 AVFoundation.framework 的一个类，它的功能类似于一个功能强大的播放器，AVAudioPlayer 支持广泛的音频格式[1]。

```
AVAudioPlayer类封装了播放单个声音的能力。播放器可以用NSURL或者NSData来初始化，要注意的是NSURL并不可以是网络url而必须是本地文件URL，

因为 AVAudioPlayer不具备播放网络音频的能力，如果要播放网络URL,需要先转化为NSData.但是此法并不可取，因为AVAudioPlayer只能播放一个完整的文件，并不支持流式播放，所以必须是缓冲完才能播放，所以如果网络文件过大抑或是网速不够岂不是要等很久？

所以播放网络音频我们一般用音频队列[3]。
```

主要是以下这些格式：AAC AMR iLBC IMA4 linearPCM u-law MP3

AVAudioPlayer 的方法
1. 初始化
  initWithContentsOfURL: error: 从URL加载音频，返回 AVAudioPlayer 对象
  initWithData: error: 加载NSdata对象的音频文件，返回 AVAudioPlayer 对象
2. 方法调用
- (BOOL)play 开始或恢复播放，调用该方法时，如果该音频还没有准备好，程序会隐士执行 - (BOOL)prepareToPlay 方法
- (void)pause 暂停
- (void)stop 停止
- (BOOL)playAtTime:(NSTimeInterval)time NS_AVAILABLE(10_7, 4_0) 在某个时间点播放
- (BOOL)prepareToPlay 准备开始播放
- (void)updateMeters 更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，通过音频测量值可以即时获得音频分贝等信息
- (float)averagePowerForChannel:(NSUInteger)channelNumber 获得指定声道的分贝峰值，注意如果要获得分贝峰值必须在此之前调用updateMeters方法
3. 读取音频信息
  -volume 播放器的音频增益，值：0.0～1.0
  pan NS_AVAILABLE(10_7, 4_0) 立体声设置 设为 －1.0 则左边播放 设为 0.0 则中央播放 设为 1.0 则右边播放
  enableRate 是否允许改变播放速率
  rate NS_AVAILABLE(10_8, 5_0) 播放速率 0.5 (半速播放) ～ 2.0(倍速播放) 注1.0 是正常速度
  playing 是否正在播放音频
  numberOfLoops 循环次数，如果要单曲循环，设置为负数
  numberOfChannels 该音频的声道次数 (只读)
  duration 该音频时长
  currentTime 该音频的播放点
  deviceCurrentTime 输出设备播放音频的时间，注意如果播放中被暂停此时间也会继续累加
  url 音频文件路径，只读
  data 音频数据，只读
  channelAssignments 获得或设置播放声道
4. 代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag; 音频播放完成
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error 音频解码发生错误
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player 如果音频被中断，比如有电话呼入，该方法就会被回调，该方法可以保存当前播放信息，以便恢复继续播放的进度。[1]



[1] [iOS开发-AVAudioPlayer音乐播放、按钮音效震动](https://blog.csdn.net/weixin_33843947/article/details/86860313)

[2] [iOS-使用AudioServices相关接口的连续震动](https://www.jianshu.com/p/dded314dd920)

[3] [AVAudioPlayer](https://www.cnblogs.com/laolitou-ping/p/6257265.html)

#  AudioServicesPlaySystemSound

对于简单的、无混音音频，AVAudio ToolBox框架提供了一个简单的C语言风格的音频服务。你可以使用AudioservicesPlaySystemSound函数来播放简单的声音，如在设置界面设置的系统铃声、震动。要遵守以下几个规则：

1.音频长度小于30秒

2.格式只能是PCM或者IMA4

3.文件必须被存储为.caf、.aif、或者.wav格式

4.简单音频不能从内存播放，而只能是磁盘文件

除了对简单音频的限制外，你对于音频播放的方式也基本无法控制。

一旦音频播放就会立即开始，而且是当前电话使用者设置的音量播放【iOS11以上由系统的Settings-Sounds & Haptics的RING AND ALERTS来控制响铃声音大小，并且无法通过音量键改变。The volume of the ringer and alerts will not be affected by thevolume buttons。】。

你将无法循环播放声音【除非在回调函数中递归调用，以达到循环播放的目标。】，也无法控制立体声效果。不过你还是可以设置一个回调函数，在音频播放结束时被调用，这样你就可以对音频对象做清理工作，以及通知你的程序播放结束。

不能在后台播放，一旦到后台或者切换到其他应用，则会停止播放。

[1] [AudioServicesPlaySystemSound](https://www.cnblogs.com/ruzhuan/p/3176715.html)

[2] [iOS持续振动 想停就停](https://www.cnblogs.com/rywt/p/6604473.html)【尚未总结】

