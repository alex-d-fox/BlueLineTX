@interface PropertyView : UITableViewController <UISearchBarDelegate> {
    NSString * value;
}
-(void)setValue:(NSString*)string;
@end
