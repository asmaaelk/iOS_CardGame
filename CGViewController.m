//
//  CGViewController.m
//  CG1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "CGViewController.h"
#import "Card.h"
#import "FrenchPlayingCardDeck.h"
#import "MatchingGame.h"
@interface CGViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;

@property (nonatomic) int highScore;
@property (strong, nonatomic) MatchingGame *game;

@end

@implementation CGViewController

- (MatchingGame *) game {
	if (!_game)
		_game = [[MatchingGame alloc] initWithNumCards:[self.cardButtons count]
											  fromDeck:[self createDeck]
										   andMatchType:[self gameType]
				 ];
	return _game;
}

- (Deck *) createDeck {
	return [[FrenchPlayingCardDeck alloc] init];
}

- (IBAction)startNewGame:(id)sender {
	self.game = nil;
	[self.gameTypeControl setEnabled:YES];
	[self updateUI];
}

- (void) updateUI {
	UIImage *cardImage;
	for (UIButton *button in self.cardButtons) {
		[button setEnabled:YES];
		NSUInteger buttonIndex = [self.cardButtons indexOfObject:button];
		Card *card = [self.game cardAtIndex:buttonIndex];
		if (card.isChosen) {
			cardImage = [UIImage imageNamed:@"cardfront"];
			[button setBackgroundImage:cardImage forState:UIControlStateNormal];
			[button setTitle:card.contents forState:UIControlStateNormal];
			if (card.isMatched)
				[button setEnabled:NO];				
		} else {
			cardImage = [UIImage imageNamed:@"cardback"];
			[button setBackgroundImage:cardImage forState:UIControlStateNormal];
			[button setTitle:@"" forState:UIControlStateNormal];
		}
	}
	[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
	[self.highScoreLabel setText:[NSString stringWithFormat:@"High Score: %d", self.highScore]];
}
- (IBAction)touchedCardButton:(UIButton *)sender {
	NSLog(@"card button pressed");
	[self.gameTypeControl setEnabled:NO];
	NSUInteger index = [self.cardButtons indexOfObject:sender];
	[self.game chooseCardAtIndex:index];
	if (self.game.score > self.highScore)
		self.highScore = self.game.score;
	[[NSUserDefaults standardUserDefaults] setInteger:self.highScore
											   forKey:@"highScore"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self updateUI];
	
	
}

#define TWO_MATCH 2
#define THREE_MATCH 3

- (NSInteger) gameType {
	if (self.gameTypeControl.selectedSegmentIndex == 0)
		return TWO_MATCH;
	else
		return THREE_MATCH;
}

- (IBAction)changeGameType {
	self.game.gameType = [self gameType];
	NSLog(@"gt %d", self.game.gameType);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	int savedHighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"];
	self.highScore = savedHighScore;
	[self updateUI];
}

@end
