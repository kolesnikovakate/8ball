//
//  SettingsViewController.h
//  EightBall
//
//  Created by Екатерина Колесникова on 06.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsCell.h"

@interface SettingsViewController : UIViewController < UITableViewDelegate, UITableViewDataSource,
                                                        SettingsCellDelegate >

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
