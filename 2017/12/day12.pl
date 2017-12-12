use Data::Dumper;
use List::MoreUtils 'first_index'; 

$input_test = "0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5";

my $input = "a";
open(my $handle, "input.txt") or die $!;
while (my $row = <$handle>) {
  $input = $input . $row;
}

@lines = split(/\n/, $input);
%links = map {
  (split(/\ <->\ /, $_))[0] => [split(/,\ /, (split(/\ <->\ /, $_))[1])]
} @lines;
my @counted = ();
my @grouped = ();

sub count {
  my ($which) = @_;
  my $total = 0;
  for my $i (0 .. $#{ $links{$which} }) {
    $val = $links{$which}[$i];
    $seek = grep { $_ == $val } @counted;
    if($seek == 0) {
      push @counted, $val;
      $total += 1;
      $total += count($val);
    }
  }
  return $total;
}

sub group {
  while(my($key, $val) = each %links) {
    $group = first_index { /,$key,/ } @grouped;
    $entry = join(",", $key, @{$val});
    print("Looking at ", $key, ", ", @{$val}, "\n");
    if($group == -1) {
      print("No key found look for values\n");
      my $found = 0;
      foreach $i (@{$val}) {
        # print($i);
        $group = first_index { /,$i,/ } @grouped;
        if($group != -1) {
          $found = 1;
          last;
        }
      }
      if($found == 0) {
        push @grouped, "," . $entry . ",";
      } else {
        @grouped[$group] = @grouped[$group] . $entry . ",";
      }
    } else {
      print("Key found, appending\n");
      print("Before", Dumper(@grouped[$group]));
      @grouped[$group] = @grouped[$group] . $entry . ",";
      print("After", Dumper(@grouped[$group]));
    }
  }
}

group();
print(Dumper(@grouped));
print("groups: ", $#grouped, "\n");