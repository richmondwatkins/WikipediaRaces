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
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property NSInteger totalScoreForGame;
@property (weak, nonatomic) IBOutlet UILabel *timerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;


@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    self.numberOfGameClicks.text = self.clickCounterData;
    self.timerLabel.text = self.timerData;;
    NSInteger timerInt = [self.timerData intValue];
    NSInteger timerScore = 500 - timerInt;
    NSInteger clicks = [self.numberOfGameClicks.text integerValue];
    NSInteger clickScore = 500 - (clicks * 20);

    self.totalScoreForGame = timerScore + clickScore;
    self.finalScore = [NSString stringWithFormat:@"%ld", (long)self.totalScoreForGame];


    NSUserDefaults *saved = [NSUserDefaults standardUserDefaults];
    NSString *stringHighScoreCurrent = [saved stringForKey:@"UserHighScore"];
    NSInteger highScoreInt = [stringHighScoreCurrent integerValue];

    if (self.totalScoreForGame > highScoreInt) {

        NSUserDefaults *saveHighScore = [NSUserDefaults standardUserDefaults];
        [saveHighScore setObject: self.finalScore forKey:@"UserHighScore"];

    }

    NSUserDefaults *totalScore = [NSUserDefaults standardUserDefaults];
    NSInteger currentTotalScore = [totalScore integerForKey:@"Current Total"];
    currentTotalScore += self.totalScoreForGame;
    [totalScore setInteger: currentTotalScore forKey:@"Current Total"];

    self.timerScoreLabel.text =[NSString stringWithFormat:@"%ld", (long)timerScore];
    self.clickScoreTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)clickScore];
    self.totalScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.totalScoreForGame];
    

}


- (void)prepareForSegue:(UIStoryboardSegue *)backHomeSeguethree sender:(id)sender {
    ViewController *viewController = backHomeSeguethree.destinationViewController;
    viewController.playAgain = self.title;

}





@end
