fn main() {
    let x = 5;                  // a variable binding

    let (x, y) = (1, 2);        // the LHS is actually a pattern

    let x: i32 = 4;             // type annotations
    let x = 4;                  // same as above, i32 is the default

    let x = 10;                 // variables are immutable by default
    // x = 11;                     compilation error on reassignment
    let mut x = 10;             // explicitly declare mutable variables
    x = 11;                     // reassignment compiles

    let mut x = 10;             // outer scope
    {
        x = 11;                 // 
        let mut y_in = 10;      // inner scope
    }
    x = 12;
    // y_in = 10;                  compilation error on assigning to inner scope
    let x = 13;                 // shadowing

    let mut x: i32 = 1;
    x = 7;
    let x = x;                 // x is now immutable and is bound to 7
    let mut x = x;             // x is now mutable
    let y = 4;
    let y = "I can also be bound to text!"; // y is now of a different type
}
