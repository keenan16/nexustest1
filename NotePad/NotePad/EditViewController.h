//
// EditViewController.h
//  NotePad
//
//  Created by Keenan Lania on 10/03/2017.
//  Copyright © 2017 Victoria Court. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextViewDelegate>{
    NSInteger noteIndex;
    NSString * note;
}
@property(nonatomic)NSInteger noteIndex;
@property(nonatomic,retain)NSString * note;
@end

