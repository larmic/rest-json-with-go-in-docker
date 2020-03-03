package main

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"io/ioutil"
	"log"
	"net/http"
)

type HRef struct {
	Href string `json:"href"`
}

type HateoasLink struct {
	Self   HRef   `json:"self"`
	Member []HRef `json:"member"`
}

type Channel struct {
	Identifier     string      `json:"identifier"`
	Name           string      `json:"name"`
	Description    string      `json:"description"`
	Type           string      `json:"type"`
	Membership     string      `json:"membership"`
	CreateDate     string      `json:"createDate"`
	LastUpdateDate string      `json:"lastUpdateDate"`
	Links          HateoasLink `json:"_links"`
}

func GetChannels(w http.ResponseWriter, _ *http.Request) {
	println("Loading response.json")
	dat, _ := ioutil.ReadFile("response.json")
	println("response.json loaded")
	println(string(dat))

	println("Unmarshalling json")
	var channels []Channel
	_ = json.Unmarshal(dat, &channels)

	println(fmt.Sprintf("%d%s", len(channels), " channels loaded"))

	for _, channel := range channels {
		println(fmt.Sprintf("%s%s%s", "Channel '", channel.Name, "' loaded"))
	}

	_ = json.NewEncoder(w).Encode(channels)
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/api/channels", GetChannels).Methods("GET")
	log.Fatal(http.ListenAndServe(":8080", router))
}
