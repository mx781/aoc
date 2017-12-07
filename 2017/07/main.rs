use std::env;
use std::fs::File;
use std::io::prelude::*;
use std::collections::HashMap;

#[derive(Debug)]
struct Tower {
  name: String,
  weight: i32,
  discs: Vec<Tower>
}

fn read_file(filename: String) -> String {
  let mut f = File::open(filename).expect("file not found");
  let mut contents = String::new();
  f.read_to_string(&mut contents)
    .expect("fucked file");
  contents
}

fn split(string: String, separator: &str) -> Vec<String> {
  string.split(separator).map(|entry| entry.to_string()).collect()
}

fn main () {
  let contents = read_file(String::from("input.txt"));
  let mut lines = split(contents, "\n");
  lines.pop();
  let mut towers: HashMap<String, Tower> = HashMap::new();
  let mut tower_bindings: HashMap<String, Vec<String>> = HashMap::new();

  fn get_name_and_weight(id_string: &str) -> (String, i32) {
    let name_and_weight = split(String::from(id_string.to_string()), " ");
    let name = String::from(name_and_weight[0].to_string());
    let weight_str = name_and_weight[1].to_string();
    let parens: &[_] = &['(', ')'];
    let weight_trimmed = weight_str.trim_matches(parens);
    let weight = weight_trimmed.parse::<i32>().unwrap();
    (name, weight)
  }

  for line in lines {
    let line_info = split(line, " -> ");
    let ref id_string = &line_info[0];
    let name_and_weight = get_name_and_weight(id_string);

    if line_info.len() == 2 {
      // Also has binding
      let ref disc_id_string = &line_info[1];
      let disc_ids: Vec<String> = split(disc_id_string.to_string(), ",")
        .iter()
        .map(|s| s.trim().to_string())
        .collect();
      tower_bindings.insert(name_and_weight.clone().0, disc_ids);
      // println!("defbind {:?}", tower_bindings);
    }

    towers.insert(name_and_weight.clone().0, Tower {
      name: name_and_weight.0,
      weight: name_and_weight.1,
      discs: Vec::new()
    });
  }

  for tower in towers {
    let mut found = false;
    let tower_name = tower.0;
    println!("{:?}", tower_name);
    for binding in tower_bindings.iter() {
      let search = binding.clone().1.iter().position(|r| r.to_string() == tower_name);
      match search {
        Some(size) => found = true,
        None => println!("not found"),
      }
      // println!("{:?}", search);
      // let tower = towers.entry(binding.0);
      // for 
      // *tower.discs
    }
    if found == false {
      println!("not found elsewhere {:?}", tower_name);
    }

  }

  // let towers
  // for binding in tower_bindings {
  //   let tower = towers.entry(binding.0);
    // for 
    // *tower.discs
  //   println!("{:?}", tower);
  // }

  // println!("{:?}", towers);
  // let towers: Vec<Tower> = lines.iter().map(|line| Tower {
  //   name: split(line, " ")[0],
  //   weight: split(line[0], " ")[1],
  //   discs: Vec::new()
  // });
  // println!("contents {:?}", towers);

}

// use std::env;
// use std::fs::File;
// use std::io::prelude::*;

// struct Tower {
//   name: String,
//   weight: i32,
//   discs: Vec<Tower>
// }

// fn read_file(filename: String) -> String {
//   let mut f = File::open(filename).expect("file not found");
//   let mut contents = String::new();
//   f.read_to_string(&mut contents)
//     .expect("fucked file");
//   contents
// }

// fn split(string: String, separator: String) -> Vector<String> {
//   string.split(separator).map(|entry| entry.to_string()).collect()
// }

// fn main () {
//   let contents = read_file(String::from("input.txt"));
//   let mut lines: Vec<Vec<String>> = contents.lines()
//     .map(|line| line.to_string())
//     .map(|line| split(line, " -> ").map(|entry| entry.to_string()).collect())
//     .collect();
//   let towers: Vec<Tower> = lines.map(|line| Tower { name: line[0].split(" ").collect(), )
//   println!("contents {:?}", lines);

// }
