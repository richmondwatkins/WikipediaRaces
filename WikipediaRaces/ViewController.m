//
//  ViewController.m
//  WikipediaRaces
//
//  Created by Michael Maloof on 10/3/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ViewController.h"
#import "WikipediaViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UILabel *wikiRacesTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *beginWastingLife;
@property NSString *startWord;
@property NSString *endWord;
@property NSString *totalScoreString;
@property (weak, nonatomic) IBOutlet UILabel *highScore;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toLabel.hidden = YES;
    self.connectLabel.hidden = YES;
    self.firstWordLabel.hidden = YES;
    self.secondWordLabel.hidden = YES;
    self.beginWastingLife.hidden = YES;

    NSUserDefaults *saved = [NSUserDefaults standardUserDefaults];
    NSString *stringHighScore = [saved stringForKey:@"UserHighScore"];
    self.highScore.text = stringHighScore;


    NSUserDefaults *totalScore = [NSUserDefaults standardUserDefaults];
    NSInteger currenttotalScore = [totalScore integerForKey:@"Current Total"];
    self.totalScoreString = [NSString stringWithFormat:@"%ld", (long)currenttotalScore];
    self.totalScoreLabel.text = self.totalScoreString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onStartButtonPressed:(id)sender {

    self.startButton.hidden = YES;
    self.warningLabel.hidden = YES;
    self.wikiRacesTitleLabel.hidden = YES;

    self.toLabel.hidden = NO;
    self.connectLabel.hidden = NO;
    self.firstWordLabel.hidden = NO;
    self.secondWordLabel.hidden = NO;
    self.beginWastingLife.hidden = NO;
    // Above, when the button clicked the top three self's dissapear and the bottom four show up. This is where the user sees the word they start with and then end. The two words need to be chosen at random each time. We should pull from a list of like 1000 names we pre make just to controll it early on.
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.startWord = @"Planet";
    self.endWord = @"Earth";
    WikipediaViewController *wikiCtrler = segue.destinationViewController;
    wikiCtrler.wordOne = self.startWord;
    wikiCtrler.wordTwo = self.endWord;
}


@end
