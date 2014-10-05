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
@property (weak, nonatomic) IBOutlet UILabel *goldMedalEarned;
@property (weak, nonatomic) IBOutlet UILabel *silverMedalEarned;
@property (weak, nonatomic) IBOutlet UILabel *bronzeMedalEarned;


@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goldMedalEarned.hidden = YES;
    self.silverMedalEarned.hidden = YES;
    self.bronzeMedalEarned.hidden = YES;

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

    if (clicks <= 5) {

        NSUserDefaults *goldMedal = [NSUserDefaults standardUserDefaults];
        NSInteger doYouHaveGold = 1;
        [goldMedal setInteger: doYouHaveGold forKey: @"Check for Gold"];
        self.goldMedalEarned.hidden = NO;


}
    if (clicks <= 8 && clicks > 5) {

        NSUserDefaults *silverMedal = [NSUserDefaults standardUserDefaults];
        NSInteger doYouHaveSilver = 1;
        [silverMedal setInteger: doYouHaveSilver forKey: @"Check for Silver"];
        self.silverMedalEarned.hidden = NO;

    }

    if (clicks <= 12 && clicks > 8) {

        NSUserDefaults *bronzeMedal = [NSUserDefaults standardUserDefaults];
        NSInteger doYouHaveBronze = 1;
        [bronzeMedal setInteger: doYouHaveBronze forKey: @"Check for Bronze"];
        self.bronzeMedalEarned.hidden = NO;
    }

}



















@end
