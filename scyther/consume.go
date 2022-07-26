package main

import (
	"github.com/gastrodon/psyduck/sdk"
)

func consumeQueue(parse sdk.Parser, specParse sdk.SpecParser) (sdk.Consumer, error) {
	config := scytherConfigDefault()
	if err := parse(config); err != nil {
		return nil, err
	}

	if err := ensureQueue(config); err != nil {
		return nil, err
	}

	return func() (chan []byte, chan error) {
		data := make(chan []byte, 32)
		errors := make(chan error)

		next := func(data []byte) (bool, error) {
			return true, putQueueHead(config, data)
		}

		go func() {
			sdk.ConsumeChunk(next, specParse, data, errors)
			close(data)
			close(errors)
		}()

		return data, errors
	}, nil
}
