package main

import (
	"bufio"
	"fmt"
	"os"
)

func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

func main() {
	forest, err := readLines("input.txt")
	if err != nil {
		panic(err)
	}
	slopes := [4]int{1, 3, 5, 7}
	var counter [5]uint
	for idxSl, sl := range slopes {
		for idxPa, pa := range forest {
			if pa[(sl*idxPa)%31] == 35 { // =#
				counter[idxSl]++
			}
		}
	}
	for idx, pa := range forest {
		if idx%2 == 0 {
			continue
		}
		if pa[idx%31] == 35 { // =#
			counter[4]++
		}
	}
	var result uint = 1
	for _, count := range counter {
		result *= count
	}
	fmt.Println(result)
}
