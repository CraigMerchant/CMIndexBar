Simple replacement for UITableView Index that allows setting of colors.
-----------------------------------------------------------------------

**Now it supports ARC.**

Usage example:

```Objective-C
CMIndexBar *indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-35, 10.0, 28.0, self.view.frame.size.height-20)];
[indexBar setIndexes:[NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil]];
[self.view addSubview:indexBar];
```

Delegate:

```Objective-C
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString*)title;
```

ToDo:
-----
1. ~~Font changing support~~
1. UITableViewIndexSearch glyph support


