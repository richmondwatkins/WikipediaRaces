//
//  ResultsViewController.m
//  WikipediaRaces
//
//  Created by Michael Maloof on 10/3/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ResultsViewController.h"
#import "ViewController.h"

@interface ResultsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *numberOfGameClicks;
@property (strong, nonatomic) IBOutlet UILabel *totalGameTime;

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    self.numberOfGameClicks.text = self.clickCounterData;
}


- (void)prepareForSegue:(UIStoryboardSegue *)backHomeSeguethree sender:(id)sender {
    ViewController *viewController = backHomeSeguethree.destinationViewController;
    viewController.playAgain = self.title;
}

@end
