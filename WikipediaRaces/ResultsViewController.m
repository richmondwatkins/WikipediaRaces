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
@property NSString *finalScore;
@property (weak, nonatomic) IBOutlet UILabel *clickScoreTotalLabel;


@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    uint32_t rnd = arc4random_uniform(100);
    NSInteger finalScoreInt = rnd;
    self.finalScore = [NSString stringWithFormat:@"%ld", (long)finalScoreInt];


    NSUserDefaults *saved = [NSUserDefaults standardUserDefaults];
    NSString *stringHighScoreCurrent = [saved stringForKey:@"UserHighScore"];
    NSInteger highScoreInt = [stringHighScoreCurrent integerValue];

    if (finalScoreInt > highScoreInt) {

    NSUserDefaults *saveHighScore = [NSUserDefaults standardUserDefaults];
    [saveHighScore setObject: self.finalScore forKey:@"UserHighScore"];

    }
    
    NSUserDefaults *totalScore = [NSUserDefaults standardUserDefaults];
    NSInteger currentTotalScore = [totalScore integerForKey:@"Current Total"];
    currentTotalScore += finalScoreInt;
    [totalScore setInteger: currentTotalScore forKey:@"Current Total"];



}

-(void)viewDidAppear:(BOOL)animated{
    self.numberOfGameClicks.text = self.clickCounterData;
    NSInteger clicks = [self.numberOfGameClicks.text integerValue];
    NSInteger clickScore = 500 - (clicks * 20);
    self.clickScoreTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)clickScore];
    

}


- (void)prepareForSegue:(UIStoryboardSegue *)backHomeSeguethree sender:(id)sender {
    ViewController *viewController = backHomeSeguethree.destinationViewController;
    viewController.playAgain = self.title;

}





@end
