//
//  SettingsCell.m
//  EightBall
//
//  Created by Екатерина Колесникова on 13.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell

- (void)awakeFromNib {
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle      = UITableViewCellSelectionStyleDefault;
}

- (IBAction)changeValueSoundSwitch:(id)sender {
    [self.delegate changeValueSoundSwitchInCell:self];
}

@end
