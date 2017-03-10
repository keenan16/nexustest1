//
//  Note.m
//  NotePad
//
//  Created by Keenan Lania on 10/03/2017.
//  Copyright © 2017 Victoria Court. All rights reserved.
//

#import "Note.h"

@implementation Note
-(id)init{
    self = [super init];
    
    if (self) {
        self.note_title = @"";
        self.note = @"";
    }
    return self;
}
@end
