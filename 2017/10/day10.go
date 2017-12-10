package main
import (
  "fmt"
  "io/ioutil"
  "strings"
  "strconv"
)

func buildList(length int) []int {
  list := make([]int, length)
  for i := 0; i < length; i++ {
    list[i] = i
  }
  return list
}

func reverse(slice []int) (reversed []int) {
  reversed = make([]int, len(slice))
  for i := range slice {
    ri := len(slice) - 1 - i
    reversed[i] = slice[ri]
  }
  return
}

func readInput(fileName string) string {
  buffer, err := ioutil.ReadFile(fileName)
  if err != nil {
    fmt.Print(err)
  }
  return string(buffer) 
}

func inputToNumberList(input string) []int {
  numberStrings := strings.Split(input, ",")
  numbers := make([]int, len(numberStrings))
  for i := 0; i < len(numberStrings); i++ {
    result, err := strconv.Atoi(numberStrings[i])
    numbers[i] = result
    if err != nil {
      fmt.Println("fuck")
    }
  }
  return numbers
}

func inputToByteList(input string) []int {
  characters := strings.Split(input, "")
  bytes := make([]int, len(characters))
  for i := 0; i < len(characters); i++ {
    bytes[i] = int(characters[i][0])
  }
  return bytes
}

func hashRound(list []int, input []int, pos int, skip int) ([]int, int, int) {
  listLength := len(list)
  for i := 0; i < len(input); i++ {
    sliceWidth := input[i]
    if sliceWidth > 1 {
      doubleList := append(list, list...)
      slice := doubleList[pos : pos+sliceWidth]
      reversed := reverse(slice)
      newDoubleList := append(doubleList[:pos], reversed...)
      newDoubleList = append(newDoubleList, doubleList[pos+sliceWidth:]...)
      endSlice := newDoubleList[pos:listLength]
      startSlice := newDoubleList[len(list): len(list) + len(list) - len(endSlice)]
      list = append(startSlice, endSlice...)
    }
    pos += (sliceWidth + skip)
    if pos > (listLength - 1) {
      pos = pos % listLength
    }
    skip += 1
  }
  return list, pos, skip
}

func reduceSparseHash(sparseHash []int) []int {
  denseHash := make([]int, 16)
  for i := 0; i < len(denseHash); i++ {
    hashPart := sparseHash[i * 16 : (i + 1) * 16]
    denseHash[i] = hashPart[0]
    for j := 1; j < len(hashPart); j++ {
      denseHash[i] = denseHash[i] ^ hashPart[j]
    }
  }
  fmt.Println(denseHash)
  return denseHash
}

func denseHashToHex(denseHash []int) string {
  hexRep := make([]string, 16)
  for i := 0; i < len(denseHash); i++ {
    hexRep[i] = strconv.FormatInt(int64(denseHash[i]), 16)
    if len(hexRep[i]) == 1 {
      withPad := []string{"0", hexRep[i]}
      hexRep[i] = strings.Join(withPad, "")
    }
  }
  return strings.Join(hexRep, "")
}

func main () {
  // Test inputs
  // inputTest := []int{3, 4, 1, 5}

  // Part 1
  input1 := inputToNumberList(readInput("input.txt"))
  res1, _, _ := hashRound(buildList(256), input1, 0, 0)
  fmt.Println("RESULT", res1[0] * res1[1])

  // Part 2
  rounds := 64
  pos := 0
  skip := 0
  sparseHash := buildList(256)
  input2 := append(inputToByteList(readInput("input.txt")), []int{17, 31, 73, 47, 23}...)
  for r := 0; r < rounds; r++ {
    sparseHash, pos, skip = hashRound(sparseHash, input2, pos, skip)
  }
  denseHash := reduceSparseHash(sparseHash)
  fmt.Println("RESULT PT2", denseHashToHex(denseHash)) 
}