//
//  NotesViewController.m
//  NotePad
//
//  Created by Keenan Lania on 10/03/2017.
//  Copyright © 2017 Victoria Court. All rights reserved.
//

#import "NotesViewController.h"
#import "Note.h"
#import "EditViewController.h"

@interface NotesViewController (){
    UIAlertView *addNotePopUp;
}
@property (weak, nonatomic) IBOutlet UITableView *notesTbl;
@property (nonatomic,retain) NSMutableArray * notes;
@end

@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notesTbl.delegate   = self;
    self.notesTbl.dataSource = self;
    addNotePopUp.delegate    = self;
    // Do any additional setup after loading the view.
    
    UIButton *addButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 27.0f, 27.0f)];
    addButton.backgroundColor = [UIColor blueColor];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadNotes:)
                                                 name:@"reloadNotes"
                                               object:nil];
    
    self.title = @"Notes";
    self.notes = [[NSMutableArray alloc]init];
    
}

-(void)reloadNotes:(NSNotification*)notification{
    
    NSString   *newNotes  = [[notification userInfo] objectForKey:@"Note"];
    NSInteger   noteIndex = [[[notification userInfo] objectForKey:@"NoteIndex"] integerValue];
    
    Note * note = [self.notes objectAtIndex:noteIndex];
    note.note = newNotes;
    
    [self.notes replaceObjectAtIndex:noteIndex withObject:note];
    
    [self.notesTbl reloadData];
    
}

-(void)addNote{
    
    addNotePopUp = [[UIAlertView alloc] initWithTitle:@"Add Note?"
                                                     message:@"Please enter your note title:"
                                                    delegate:self
                                           cancelButtonTitle:@"Done"
                                           otherButtonTitles:nil];
    
    addNotePopUp.alertViewStyle = UIAlertViewStylePlainTextInput;
    addNotePopUp.tag = 1;
    UITextField *textField = [addNotePopUp textFieldAtIndex:0];
    textField.tag = 1;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.placeholder = @"Title";
    
    [addNotePopUp show];
    
}


- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alert.tag == 1) {
        
        UITextField *textField = [alert textFieldAtIndex:0];
        
        if(buttonIndex == 0) {
            
            [self saveNote:textField.text];
            
        }
    }
}

- (void)saveNote:(NSString*)txt{
    Note * note = [[Note alloc]init];
    note.note_title = txt;
    [self.notes addObject:note];
    [self.notesTbl reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
            
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"NotesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Note * note = [self.notes objectAtIndex:indexPath.row];
    
    cell.textLabel.text       = note.note_title;
    cell.detailTextLabel.text = @"Tap to edit";
    
    if ([note.note isEqualToString:@""]) {
        cell.detailTextLabel.text = @"Tap to edit";
    }else{
        cell.detailTextLabel.text = note.note;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"EditNote" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditNote"]) {
        NSIndexPath *indexPath = [self.notesTbl indexPathForSelectedRow];
        
        Note * noteObject = [self.notes objectAtIndex:indexPath.row];
    
        EditViewController *editViewController = segue.destinationViewController;
        editViewController.noteIndex = indexPath.row;
        editViewController.note      = noteObject.note;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
