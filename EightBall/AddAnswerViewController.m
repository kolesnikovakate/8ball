//
//  AddAnswerViewController.m
//  EightBall
//
//  Created by Екатерина Колесникова on 13.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "AddAnswerViewController.h"

@interface AddAnswerViewController ()

@end

@implementation AddAnswerViewController {
    AddAnswerView *addAnswerView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    addAnswerView_ = [[AddAnswerView alloc] initWithFrame:self.view.frame];
    addAnswerView_.delegate = self;
    addAnswerView_.dataSource = self;
    self.view = addAnswerView_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AddAnswerView delegate

- (void)addAnswerView:(AddAnswerView *)view touchUpInsideSaveButton:(UIButton *)saveButton saveAnswerText:(NSString *)answerText
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Answer *answer = [Answer MR_findFirstByAttribute:@"text" withValue:answerText inContext:localContext];
        if (answer != nil && ![answer.objectID isEqual:self.answer.objectID]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Внимание"
                                                                message:@"Такой ответ уже есть!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            return;
        } else {
            if (answer == nil && self.answer == nil) {
                answer = [Answer MR_createInContext:localContext];
                answer.text = answerText;
            } else
                self.answer.text = answerText;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - AddAnswerView dataSourse

- (NSString *)answerTextInAddAnswerView:(AddAnswerView *)addAnswerView
{
    return self.answer.text;
}

@end