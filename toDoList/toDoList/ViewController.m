//
//  ViewController.m
//  toDoList
//
//  Created by Davis Gossage on 11/10/14.
//  MIT License
//

#import "ViewController.h"
#import "DLDataModel.h"
#import "DLItemTableViewCell.h"

@interface ViewController (){
    IBOutlet UITableView *listTableView;
    UIVisualEffectView *blurEffectView;
    UITapGestureRecognizer *touchOnView;
    DLAddItemView *addItemView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self printHelloWorld];
}

-(void) printHelloWorld{
    NSLog(@"Hello World");
    
    // print formatted strings
    NSString *string = @"Hola Mundo!";
    NSLog(@"%@", string);
    
    char letter = 's';
    NSLog(@"My favorite letter is %c", letter);
    
    int n = 11;//this is a primitive
    NSLog(@"I am %d years old", n);
    
    NSInteger number = 7;//this is a object
    NSLog(@"My object integer value is %ld", (long) number);
    
    // you should use NSInteger and not int
    
    n = 24;
    n = 11;
    number = 8;
    
    // static arrays
    NSArray *basicArray1 = [NSArray arrayWithObjects:@"cat", @"dog", nil];
    NSArray *basicArray2 = @[@"rat", @"fog"];
    NSLog(@"%@", basicArray1);
    NSLog(@"%@", basicArray2);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItemButton:(id)sender{
    if (!blurEffectView){
        //blur view
        UIVisualEffect *blurEffect;
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.alpha = 0.0;
        
        blurEffectView.frame = listTableView.bounds;
        [listTableView addSubview:blurEffectView];
        
        addItemView = [[[NSBundle mainBundle] loadNibNamed:@"AddItemView" owner:self options:nil] objectAtIndex:0];
        addItemView.alpha = 0.0;
        [self.view addSubview:addItemView];
        addItemView.center = self.view.center;
        addItemView.delegate = self;
        
        [UIView animateWithDuration:.2 animations:^{
            blurEffectView.alpha = 1.0;
            addItemView.alpha = 1.0;
        }];
        
        //detect touch on blur view
        touchOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopup)];
        
        // Set required taps and number of touches
        [touchOnView setNumberOfTapsRequired:1];
        [touchOnView setNumberOfTouchesRequired:1];
        
        // Add the gesture to the view
        [blurEffectView addGestureRecognizer:touchOnView];
    }
}

- (void)hidePopup{
    [blurEffectView removeGestureRecognizer:touchOnView];
    [UIView animateWithDuration:.2 animations:^{
        blurEffectView.alpha = 0.0;
        addItemView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [addItemView removeFromSuperview];
        addItemView = nil;
        [blurEffectView removeFromSuperview];
        blurEffectView = nil;
    }];
}

#pragma mark DLAddItemView delegate

- (void)itemWasAdded{
    [listTableView reloadData];
    [self hidePopup];
}


#pragma mark tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[DLDataModel sharedInstance] currentList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    DLItem *item = [[[DLDataModel sharedInstance] currentList] objectAtIndex:[indexPath row]];
    cell.titleLabel.text = item.itemTitle;
    cell.descriptionTextView.text = item.itemDescription;
    [cell setBackgroundColor:item.backgroundColor];
    cell.iconImageView.image = item.icon;
    
    return cell;
}

#pragma mark tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLItemTableViewCell *cell = (DLItemTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell showDescription];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *previousSelection = [tableView indexPathForSelectedRow];
    DLItemTableViewCell *cell = (DLItemTableViewCell*)[tableView cellForRowAtIndexPath:previousSelection];
    [cell hideDescription];
    return indexPath;
}

@end
