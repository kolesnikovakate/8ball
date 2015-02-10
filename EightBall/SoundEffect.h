//
//  SoundEffect.h
//  EightBall
//
//  Created by Екатерина Колесникова on 10.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject
{
    SystemSoundID soundID;
}

- (id)init8BallSound;

- (id)initWithSoundNamed:(NSString *)filename;

- (void)play;

@end