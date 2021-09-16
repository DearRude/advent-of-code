package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type password struct {
	min   int
	max   int
	count int
}

func (p *password) UnmarshalBinary(data []byte) error {
	var colonIdx, dashIdx uint
	for idx, char := range data {
		switch char {
		case byte('-'):
			dashIdx = uint(idx)
		case byte(':'):
			colonIdx = uint(idx)
		}
	}
	p.min, _ = strconv.Atoi(string(data[:dashIdx]))
	p.max, _ = strconv.Atoi(string(data[dashIdx+1 : colonIdx-2]))
	char := data[colonIdx-1]
	pass := data[colonIdx+2:]

	for _, charByte := range pass {
		if char == charByte {
			p.count++
		}
	}
	return nil
}

func readLines(path string) ([]password, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var passwords []password
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lineByte := scanner.Bytes()
		pass := password{}
		if err := pass.UnmarshalBinary(lineByte); err != nil {
			return nil, err
		}
		passwords = append(passwords, pass)
	}
	return passwords, scanner.Err()
}

func main() {
	passwords, err := readLines("input.txt")
	if err != nil {
		panic(err)
	}
	var valids uint
	for _, pass := range passwords {
		if pass.min <= pass.count && pass.count <= pass.max {
			valids++
		}
	}
	fmt.Println(valids)
}
