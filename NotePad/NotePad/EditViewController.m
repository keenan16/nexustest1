//
//  EditViewController.m
//  NotePad
//
//  Created by Keenan Lania on 10/03/2017.
//  Copyright © 2017 Victoria Court. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation EditViewController
@synthesize noteIndex,note;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50.0f, 27.0f)];
    doneButton.backgroundColor = [UIColor blueColor];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = doneButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    self.textView.delegate = self;
    self.textView.text = note;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)done{
    NSMutableDictionary * theInFo = [[NSMutableDictionary alloc]init];
    [theInFo setObject:self.textView.text forKey:@"Note"];
    [theInFo setObject:[NSNumber numberWithInteger:noteIndex] forKey:@"NoteIndex"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadNotes" object:self userInfo:theInFo];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWasShown:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.textView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    self.textView.scrollIndicatorInsets = self.textView.contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    self.textView.contentInset = UIEdgeInsetsZero;
    self.textView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    [textView scrollRangeToVisible:NSMakeRange([textView.text length]-1, 1)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
