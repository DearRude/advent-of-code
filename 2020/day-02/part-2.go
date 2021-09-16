package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type password struct {
	first  byte
	second byte
	char   byte
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
	min, _ := strconv.Atoi(string(data[:dashIdx]))
	max, _ := strconv.Atoi(string(data[dashIdx+1 : colonIdx-2]))
	pass := data[colonIdx+2:]

	p.char = data[colonIdx-1]
	p.first = pass[min-1]
	p.second = pass[max-1]

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
	for _, p := range passwords {
		if (p.first == p.char && p.second != p.char) ||
			(p.first != p.char && p.second == p.char) {
			valids++
		}
	}
	fmt.Println(valids)
}
