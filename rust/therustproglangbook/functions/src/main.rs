fn main() {
    print_number(5);
    print_sum(12, 13);
    let x: i32 = diverges();    // divergent functions don't return, bind to any type
    let f: fn(i32) -> i32;      // pointer to a function that takes and i32 and returns another
}

fn print_number(x: i32) {
    println!("x is: {}", x);
}

// fn print_sum(x, y) { // type annotations are mandatory for function arguments
fn print_sum(x: i32, y: i32) {
    println!("sum is: {}", x + y);
}

fn add_one(x: i32) -> i32 {
    x + 1                       // no semicolon
}

fn early_return() -> i32 {
    return 1;
    1
}

fn return_stmt() -> i32 {
    return 1;                   // no typical rust style
}

fn diverges() -> ! {
    panic!("Never returns!");   // set RUST_BACKTRACE=1 for backtrace
}

