//
//  Player.h
//  BatteryTester
//
//  Created by Luis Flores on 10/14/13.
//  Copyright (c) 2013 Gangverk All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Player : NSObject
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
- (id)initWithVideoName:(NSString *)videoName;
- (void)playVideo;
@end
