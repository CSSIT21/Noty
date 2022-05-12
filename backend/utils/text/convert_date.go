package text

import "time"

func ConvertDate(data string) (*time.Time, error) {
	layout := "2006-01-02T15:04:05Z"
	dataTime, err := time.Parse(layout, data)
	return &dataTime, err
}
