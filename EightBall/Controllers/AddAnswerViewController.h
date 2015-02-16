//
//  AddAnswerViewController.h
//  EightBall
//
//  Created by Екатерина Колесникова on 13.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Answer.h"
#import "AddAnswerView.h"

@interface AddAnswerViewController : UIViewController < AddAnswerViewDataSource, AddAnswerViewDelegate >

@property (nonatomic, strong) Answer *answer;

@end
