struct Tree {
    name: String,
    weight: i32,
    children: Vec<Tree>
};

let sub_tree = Tree {
    name: String::from("branch"),
    weight: 12,
    children: vec![]
};

let apple_tree = Tree {
    name: String::from("apple"),
    weight: 43,
    children: vec![sub_tree]
};

fn all_members(tree: Tree) -> Vec<String> {
    match tree {
        
    }
}

fn main () {
}
