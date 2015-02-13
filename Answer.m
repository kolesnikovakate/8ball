//
//  Answer.m
//  EightBall
//
//  Created by Екатерина Колесникова on 08.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "Answer.h"

@implementation Answer

@dynamic text;
@dynamic sound;
@dynamic sense;

+ (Answer *)randomAnswer
{
    NSArray *answers = [Answer MR_findAll];
    NSUInteger randomNumber = answers.count - (arc4random() % answers.count) - 1;
    return [answers objectAtIndex:randomNumber];
}

@end

@implementation NSFetchedResultsController (Answer)

+ (NSFetchedResultsController *)fetchedResultControllerAnswers
{
    NSFetchRequest *request = [Answer MR_requestAll];

    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"text" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor1]];

    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                 managedObjectContext:[NSManagedObjectContext MR_contextForCurrentThread]
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:nil];

    NSError *error = nil;
    [controller performFetch:&error];

    NSAssert(!error, @"Answer fetch error");

    return controller;
}

@end