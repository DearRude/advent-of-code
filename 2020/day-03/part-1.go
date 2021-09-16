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

	var counter uint
	for idx, pa := range forest {
		if pa[(3*idx)%31] == 35 { // =#
			counter++
		}
	}
	fmt.Println(counter)
}
