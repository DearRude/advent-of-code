package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func readLines(path string) ([]int, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []int
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		num, _ := strconv.Atoi(scanner.Text())
		lines = append(lines, num)
	}
	return lines, scanner.Err()
}

func main() {
	expenses, err := readLines("input.txt")
	if err != nil {
		panic(err)
	}
	for idxFirst, first := range expenses {
		for idxSecond, second := range expenses[idxFirst:] {
			for _, third := range expenses[idxSecond:] {
				if first+second+third == 2020 {
					fmt.Println(first * second * third)
					break
				}
			}
		}
	}
}
