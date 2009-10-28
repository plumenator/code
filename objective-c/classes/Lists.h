// -*-ObjC-*-

@protocol Lilst
- (void) add: (id) item;
- (void) remove: (id) item;
- getAtIndex: (int) idx;
- (void) clear;
@end

@protocol LinkedList <List>
- (void) addFirst: (id) item;
- (void) addLast: (id) item;
- getFirst;
- getLast;
@end
